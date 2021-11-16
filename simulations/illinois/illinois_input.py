"""
This input file shows the State of Illinois and the University of Illinois
as a contained region. We can use this to examine how IL climate policies
influence the energy system planning of UIUC.
"""

# So the database can be saved in the location from which
# the command is called.
import os
import numpy as np
curr_dir = os.path.dirname(__file__)


# Simulation metadata goes here
iteration = "base"
folder = 'data_files'
scenario_name = 'BAU'
start_year = 2025  # the first year optimized by the model
end_year = 2050  # the last year optimized by the model
N_years = 6  # the number of years optimized by the model
N_seasons = 4  # the number of "seasons" in the model
N_hours = 24  # the number of hours in a day
database_filename = f'{folder}/IL_{scenario_name}_{N_seasons}.sqlite'  # where the database will be written


# Optional parameters
reserve_margin = {'IL':0.15}  # fraction of excess capacity to ensure reliability
discount_rate = 0.05  # The discount rate applied globally.

demands_list = []
resources_list = []
emissions_list = []

# Import demand commodities
from pygenesys.commodity.demand import ELC_DEMAND

# Add demand forecast
"""
Illinois' electricity should increase to encompass all parts of the economy
if the State wishes to be truly carbon neutral. An aggressive climate policy
would electrify everything. A limited climate policy would only decarbonize
the electric grid.
"""
ELC_DEMAND.add_demand(region='IL',
                      init_demand=1.87e5,
                      start_year=start_year,
                      end_year=end_year,
                      N_years=N_years,
                      growth_rate=0.01,
                      growth_method='linear')

pjm_path = '/home/sdotson/research/2021-dotson-ms/data/pjm_hourly_demand.csv'

ELC_DEMAND.set_distribution(region='IL',
                            data=pjm_path,
                            n_seasons=N_seasons,
                            n_hours=N_hours,
                            normalize=True)



# Import transmission technologies, set regions, import input commodities
from pygenesys.technology.transmission import TRANSMISSION
from pygenesys.commodity.resource import (electricity,
                                          ethos)
TRANSMISSION.add_regional_data(region='IL',
                               input_comm=electricity,
                               output_comm=ELC_DEMAND,
                               efficiency=1.0,
                               tech_lifetime=1000,)

# Import technologies that generate electricity
from pygenesys.technology.electric import SOLAR_FARM, WIND_FARM, NUCLEAR_CONV
from pygenesys.technology.electric import COAL_CONV, NATGAS_CONV, BIOMASS
from pygenesys.technology.electric import COAL_ADV, NATGAS_ADV, NUCLEAR_ADV
from pygenesys.technology.storage import LI_BATTERY

# Import emissions
from pygenesys.commodity.emissions import co2eq, CO2


# Import capacity factor data
from pygenesys.data.library import solarfarm_data, railsplitter_data

# wind_history = (f"/home/sdotson/research/2021-dotson-ms/data/"+
#                 f"railsplitterHistories/"+
#                 f"RailSplitterHistories_{iteration}_pd.csv")
# solar_history = (f"/home/sdotson/research/2021-dotson-ms/data/"+
#                  f"solarHistories/"+
#                  f"solarHistories_{iteration}_pd.csv")

from pygenesys.utils.tsprocess import choose_distribution_method

# Calculate the capacity factor distributions
method = choose_distribution_method(N_seasons, N_hours)
solar_cf = method(solarfarm_data, N_seasons, N_hours, kind='cf')
wind_cf = method(railsplitter_data, N_seasons, N_hours, kind='cf')
# solar_cf = method(solar_history, N_seasons, N_hours, kind='cf')
# wind_cf = method(wind_history, N_seasons, N_hours, kind='cf')

years = np.linspace(start_year, end_year, N_years).astype('int')


# Add regional data
import pandas as pd
data_path = '/home/sdotson/research/2021-dotson-ms/data/fixed_cost_projections_bfill.csv'
fixed_df = pd.read_csv(data_path, parse_dates=True, index_col='year')
data_path = '/home/sdotson/research/2021-dotson-ms/data/capital_cost_projections_bfill.csv'
capital_df = pd.read_csv(data_path, parse_dates=True, index_col='year')
nrel_years = np.array(fixed_df.index.year).astype('int')

solar_capital = np.array(capital_df['UtilityPV']).astype('float')
solar_capital = dict(zip(nrel_years, solar_capital))
solar_fixed = np.array(fixed_df['UtilityPV']).astype('float')
solar_fixed = dict(zip(nrel_years, solar_fixed))

# import technology data from EIA
from pygenesys.data.eia_data import get_eia_generators, get_existing_capacity
curr_data = get_eia_generators()
SOLAR_FARM.add_regional_data(region='IL',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=25,
                             loan_lifetime=10,
                             capacity_factor_tech=solar_cf,
                             existing=get_existing_capacity(curr_data,
                                                            'IL',
                                                            'Solar Photovoltaic'),
                             emissions={co2eq:4.8e-5},
                             cost_fixed=solar_fixed,
                             cost_invest=solar_capital
                             )
wind_capital = np.array(capital_df['LandbasedWind']).astype('float')
wind_capital = dict(zip(nrel_years, wind_capital))
wind_fixed = np.array(fixed_df['LandbasedWind']).astype('float')
wind_fixed = dict(zip(nrel_years, wind_fixed))
WIND_FARM.add_regional_data(region='IL',
                            input_comm=ethos,
                            output_comm=electricity,
                            efficiency=1.0,
                            tech_lifetime=25,
                            loan_lifetime=10,
                            capacity_factor_tech=wind_cf,
                            existing=get_existing_capacity(curr_data,
                                                           'IL',
                                                           'Onshore Wind Turbine'),
                            emissions={co2eq:1.1e-5},
                            cost_fixed=wind_fixed,
                            cost_invest=wind_capital,)

NUCLEAR_CONV.add_regional_data(region='IL',
                               input_comm=ethos,
                               output_comm=electricity,
                               efficiency=1.0,
                               tech_lifetime=60,
                               loan_lifetime=1,
                               capacity_factor_tech=0.93,
                               emissions={co2eq:1.2e-5},
                               existing=get_existing_capacity(curr_data,
                                                              'IL',
                                                              'Nuclear'),
                               cost_fixed=0.17773741,
                               cost_invest=0.05,
                               cost_variable=0.005811,
                               max_capacity = {2025:12.42e3,
                                               2030:12.42e3,
                                               2035:12.42e3,
                                               2040:12.42e3,
                                               2045:12.42e3,
                                               2050:12.42e3,},
                                               # 2050:0.0,}, # zero nuclear scenario
                               )

# Multiply capital cost by 2 to simulate cost overruns.
nuclear_capital = np.array(capital_df['Nuclear']).astype('float')*2
nuclear_capital = dict(zip(nrel_years, nuclear_capital))
nuclear_fixed = np.array(fixed_df['Nuclear']).astype('float')
nuclear_fixed = dict(zip(nrel_years, nuclear_fixed))
NUCLEAR_ADV.add_regional_data(region='IL',
                               input_comm=ethos,
                               output_comm=electricity,
                               efficiency=1.0,
                               tech_lifetime=60,
                               loan_lifetime=10,
                               capacity_factor_tech=0.93,
                               emissions={co2eq:1.2e-5},
                               ramp_up=0.25,
                               ramp_down=0.25,
                               cost_fixed=nuclear_fixed,
                               cost_invest=nuclear_capital,
                               cost_variable=0.009158,
                               # max_capacity = {2050:0.0} # zero nuclear scenario
                               )

ngcc_existing = get_existing_capacity(curr_data,
                                      'IL',
                                      'Natural Gas Fired Combined Cycle')
ngct_existing = get_existing_capacity(curr_data,
                                      'IL',
                                      'Natural Gas Fired Combustion Turbine')
import collections, functools, operator
ng_existing = dict(functools.reduce(operator.add,
                   map(collections.Counter, [ngcc_existing, ngct_existing])))
NATGAS_CONV.add_regional_data(region='IL',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=40,
                             loan_lifetime=25,
                             capacity_factor_tech=0.55,
                             emissions={co2eq:4.9e-4, CO2:1.81e-4},
                             existing=ng_existing,
                             ramp_up=1.0,
                             ramp_down=1.0,
                             cost_fixed=0.0111934,
                             cost_invest=0.95958,
                             cost_variable=0.022387
                             )
ng_capital = np.array(capital_df['NaturalGas-CCS']).astype('float')
ng_capital = dict(zip(nrel_years, ng_capital))
ng_fixed = np.array(fixed_df['NaturalGas-CCS']).astype('float')
ng_fixed = dict(zip(nrel_years, ng_fixed))
NATGAS_ADV.add_regional_data(region='IL',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=40,
                             loan_lifetime=25,
                             capacity_factor_tech=0.55,
                             emissions={co2eq:1.7e-4, CO2:1.81e-5},
                             ramp_up=1.0,
                             ramp_down=1.0,
                             cost_fixed=ng_fixed,
                             cost_invest=ng_capital,
                             cost_variable=0.027475
                             )
COAL_CONV.add_regional_data(region='IL',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=60,
                             loan_lifetime=25,
                             capacity_factor_tech=0.54,
                             emissions={co2eq:8.2e-4, CO2:3.2595e-4},
                             existing=get_existing_capacity(curr_data,
                                                            'IL',
                                                            'Conventional Steam Coal'),
                             ramp_up=0.5,
                             ramp_down=0.5,
                             cost_fixed=0.0407033,
                             cost_invest=1.000,
                             cost_variable=0.021369
                             )
coal_capital = np.array(capital_df['Coal-CCS']).astype('float')
coal_capital = dict(zip(nrel_years, coal_capital))
coal_fixed = np.array(fixed_df['Coal-CCS']).astype('float')
coal_fixed = dict(zip(nrel_years, coal_fixed))
COAL_ADV.add_regional_data(region='IL',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=60,
                             loan_lifetime=25,
                             capacity_factor_tech=0.54,
                             emissions={co2eq:2.2e-4, CO2:3.2595e-5},
                             ramp_up=0.5,
                             ramp_down=0.5,
                             cost_fixed=coal_fixed,
                             cost_invest=coal_capital,
                             cost_variable=0.0366329
                             )

biomass_capital = np.array(capital_df['Biomass']).astype('float')
biomass_capital = dict(zip(nrel_years, biomass_capital))
BIOMASS.add_regional_data(region='IL',
                          input_comm=ethos,
                          output_comm=electricity,
                          efficiency=1.0,
                          tech_lifetime=60,
                          loan_lifetime=25,
                          capacity_factor_tech=0.61,
                          emissions={co2eq:2.3e-4},
                          cost_fixed=0.123,
                          cost_invest=biomass_capital,
                          cost_variable=0.047
                          )

libatt_capital = np.array(capital_df['Battery']).astype('float')
libatt_capital = dict(zip(nrel_years, libatt_capital))
libatt_fixed = np.array(fixed_df['Battery']).astype('float')
libatt_fixed = dict(zip(nrel_years, libatt_fixed))
LI_BATTERY.add_regional_data(region='IL',
                             input_comm=electricity,
                             output_comm=electricity,
                             efficiency=0.85,
                             capacity_factor_tech=0.2,
                             tech_lifetime=15,
                             loan_lifetime=5,
                             existing=get_existing_capacity(curr_data,
                                                            'IL',
                                                            'Batteries'),
                             emissions={co2eq:2.32e-5},
                             cost_invest=libatt_capital,
                             cost_fixed=libatt_fixed,
                             storage_duration=4)

# 2050 carbon limits

if scenario_name == "CC50":
    print('Applying constraints carbon neutral by 2050')
    CO2.add_regional_limit(region='IL',
                           limits={2025:52.34375,
                                   2030:41.875,
                                   2035:31.40625,
                                   2040:20.9375,
                                   2045:10.46875,
                                   2050:0.0})

# 2030 carbon limits
elif scenario_name == "CC30":
    print('Applying constraints carbon neutral by 2030')
    CO2.add_regional_limit(region='IL',
                           limits={2025:27.917,
                                   2030:0.0,
                                   2035:0.0,
                                   2040:0.0,
                                   2045:0.0,
                                   2050:0.0,})

else:
    print('No carbon limits -- Business as usual')

demands_list = [ELC_DEMAND]
resources_list = [electricity, ethos]
emissions_list = [co2eq, CO2]

if __name__ == "__main__":
    import numpy as np


    """
    This data is based on data from EIA
    """
    y0 = 67.0
    x0 = 2018
    x1 = 2030
    y1 = 0.0

    m = (y1-y0)/(x1-x0)
    print(ELC_DEMAND.demand['IL'])

    y = lambda x, slope, start, b: slope*(x-start) + b
    test_years = np.linspace(x0,x1,(x1-x0))
    limit = y(years, m, x0, y0)
    for i, l, in enumerate(limit):
        print(i*5+2025, l)
    import matplotlib.pyplot as plt
    # plt.style.use('ggplot')
    # plt.plot(years, limit, marker='o')
    # plt.ylim(0,70)
    # plt.minorticks_on()
    # plt.show()

    test_path = "/home/sdotson/research/2021-dotson-ms/data/PG_2010.csv"
    dist_method = choose_distribution_method(N_seasons=N_seasons, N_hours=N_hours)
    check_dist = dist_method(test_path)
    for i, s in enumerate(SOLAR_FARM.capacity_factor_tech['IL']):
        plt.plot(range(24), s, label=f'season {i}', marker='o')
        plt.plot(range(24), check_dist[i], label=f"TEST {i}", marker='^')
    plt.show()


    # plt.plot(solar_fixed.keys(), solar_fixed.values(), label='solar fc')
    # plt.plot(wind_fixed.keys(), wind_fixed.values(), label='wind fc', marker='^')
    # plt.legend()
    # plt.show()
    #
    # plt.plot(solar_capital.keys(), solar_capital.values(), label='solar cc')
    # plt.plot(wind_capital.keys(), wind_capital.values(), label='wind cc', marker='^')
    # plt.show()
    # print(solar_capital)
