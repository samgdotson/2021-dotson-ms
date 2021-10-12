"""
This input file shows the State of Illinois and the University of Illinois
as a contained region. We can use this to examine how IL climate policies
influence the energy system planning of UIUC.
"""

# So the database can be saved in the location from which
# the command is called.
import os
curr_dir = os.path.dirname(__file__)


# Simulation metadata goes here
database_filename = 'IL_BAU.sqlite'  # where the database will be written
scenario_name = 'BAU'
start_year = 2025  # the first year optimized by the model
end_year = 2050  # the last year optimized by the model
N_years = 6  # the number of years optimized by the model
N_seasons = 4  # the number of "seasons" in the model
N_hours = 24  # the number of hours in a day

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

import numpy as np
il_dds = np.loadtxt('/home/sdotson/research/2021-dotson-ms/data/il_elc_dds.txt')

ELC_DEMAND.set_distribution(region='IL',
                            data=il_dds,
                            normalize=False)



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
from pygenesys.technology.electric import COAL_CONV, NATGAS_CONV
from pygenesys.technology.electric import COAL_ADV, NATGAS_ADV, NUCLEAR_ADV
from pygenesys.technology.storage import LI_BATTERY

# Import emissions
from pygenesys.commodity.emissions import co2eq, CO2


# Import capacity factor data
from pygenesys.data.library import solarfarm_data, railsplitter_data
from pygenesys.utils.tsprocess import choose_distribution_method

# Calculate the capacity factor distributions
method = choose_distribution_method(N_seasons, N_hours)
solar_cf = method(solarfarm_data, N_seasons, N_hours, kind='cf')
wind_cf = method(railsplitter_data, N_seasons, N_hours, kind='cf')

years = np.linspace(start_year, end_year, N_years).astype('int')


# Add regional data

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
                             cost_fixed=19.3341,
                             cost_invest=1.593533
                             )

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
                            cost_fixed=40.723,
                            cost_invest=1.8784,)

NUCLEAR_CONV.add_regional_data(region='IL',
                               input_comm=ethos,
                               output_comm=electricity,
                               efficiency=1.0,
                               tech_lifetime=60,
                               loan_lifetime=25,
                               capacity_factor_tech=0.93,
                               emissions={co2eq:1.2e-5},
                               existing=get_existing_capacity(curr_data,
                                                              'IL',
                                                              'Nuclear'),
                               cost_fixed=177.73741,
                               cost_invest=0.05,
                               cost_variable=0.005811
                               )
NUCLEAR_ADV.add_regional_data(region='IL',
                               input_comm=ethos,
                               output_comm=electricity,
                               efficiency=1.0,
                               tech_lifetime=60,
                               loan_lifetime=25,
                               capacity_factor_tech=0.93,
                               emissions={co2eq:1.2e-5},
                               ramp_up=0.25,
                               ramp_down=0.25,
                               cost_fixed=121.09221,
                               cost_invest=5.90583,
                               cost_variable=0.009158
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
                             cost_fixed=11.1934,
                             cost_invest=0.95958,
                             cost_variable=0.022387
                             )
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
                             cost_fixed=27.4747,
                             cost_invest=2.7128728,
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
                             cost_fixed=40.7033,
                             cost_invest=1.000,
                             cost_variable=0.021369
                             )
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
                             cost_fixed=59.017,
                             cost_invest=6.0352770,
                             cost_variable=0.0366329
                             )

LI_BATTERY.add_regional_data(region='IL',
                             input_comm=electricity,
                             output_comm=electricity,
                             efficiency=0.80,
                             capacity_factor_tech=0.2,
                             tech_lifetime=12,
                             loan_lifetime=5,
                             existing=get_existing_capacity(curr_data,
                                                            'IL',
                                                            'Batteries'),
                             emissions={co2eq:2.32e-5},
                             cost_invest=1.608,
                             cost_fixed=25.102,
                             storage_duration=8)

# CO2.add_regional_limit(region='IL',
#                        limits={2025:0.344,
#                                2030:0.30,
#                                2035:0.25,
#                                2040:0.2,
#                                2035:0.1,
#                                end_year:0.0})

demands_list = [ELC_DEMAND]
resources_list = [electricity, ethos]
emissions_list = [co2eq, CO2]

if __name__ == "__main__":
    import numpy as np
