"""
This input file shows the State of Illinois and the University of Illinois
as a contained region. We can use this to examine how IL climate policies
influence the energy system planning of UIUC.
"""

# So the database can be saved in the location from which
# the command is called.
import os
curr_dir = os.path.dirname(__file__)


iteration = "base"
folder = 'data_files'
scenario_name = 'LIMSOL'
start_year = 2025  # the first year optimized by the model
end_year = 2050  # the last year optimized by the model
N_years = 6  # the number of years optimized by the model
N_seasons = 52  # the number of "seasons" in the model
N_hours = 24  # the number of hours in a day
database_filename = f'{folder}/UIUC_{scenario_name}_{N_seasons}.sqlite'  # where the database will be written

# Optional parameters
reserve_margin = {'UIUC':0.15}  # fraction of excess capacity to ensure reliability
discount_rate = 0.05  # The discount rate applied globally.

demands_list = []
resources_list = []
emissions_list = []

# Import demand commodities
from pygenesys.commodity.demand import ELC_DEMAND, STM_DEMAND, CW_DEMAND
from pygenesys.commodity.demand import TRANSPORT

# Add demand forecast
ELC_DEMAND.add_demand(region='UIUC',
                      init_demand=445.87,
                      start_year=start_year,
                      end_year=end_year,
                      N_years=N_years,
                      growth_rate=0.01,
                      growth_method='linear')

STM_DEMAND.add_demand(region='UIUC',
                      init_demand=505.51,
                      start_year=start_year,
                      end_year=end_year,
                      N_years=N_years,
                      growth_rate=0.01,
                      growth_method='linear')
CW_DEMAND.add_demand(region='UIUC',
                     init_demand=83.848,
                     start_year=start_year,
                     end_year=end_year,
                     N_years=N_years,
                     growth_rate=0.01,
                     growth_method='linear')

# Set demand distributions, import data
from pygenesys.data.library import (campus_elc_demand,
                                    campus_stm_demand,
                                    campus_cw_demand)
import numpy as np


ELC_DEMAND.set_distribution(region='UIUC',
                            data=campus_elc_demand,
                            n_seasons=N_seasons,
                            n_hours=N_hours)

STM_DEMAND.set_distribution(region='UIUC',
                            data=campus_stm_demand,
                            n_seasons=N_seasons,
                            n_hours=N_hours)
CW_DEMAND.set_distribution(region='UIUC',
                           data=campus_cw_demand,
                           n_seasons=N_seasons,
                           n_hours=N_hours)


# Import transmission technologies, set regions, import input commodities
from pygenesys.technology.transmission import STM_TUNNEL, TRANSMISSION, CW_PIPES
from pygenesys.technology.transmission import IMP_ELC
from pygenesys.commodity.resource import (electricity,
                                          steam,
                                          chilled_water,
                                          nuclear_steam,
                                          ethos)
STM_TUNNEL.add_regional_data(region='UIUC',
                             input_comm=[steam, nuclear_steam],
                             output_comm=STM_DEMAND,
                             efficiency=1.0,
                             tech_lifetime=1000,)
TRANSMISSION.add_regional_data(region='UIUC',
                               input_comm=electricity,
                               output_comm=ELC_DEMAND,
                               efficiency=1.0,
                               tech_lifetime=1000,)
CW_PIPES.add_regional_data(region='UIUC',
                           input_comm=chilled_water,
                           output_comm=CW_DEMAND,
                           efficiency=1.0,
                           tech_lifetime=1000,)


# Import technologies that generate electricity
from pygenesys.technology.electric import SOLAR_FARM, WIND_FARM
from pygenesys.technology.electric import NUCLEAR_TB, ABBOTT_TB

# Import emissions
from pygenesys.commodity.emissions import co2eq, CO2


# Import capacity factor data
from pygenesys.data.library import solarfarm_data, railsplitter_data
from pygenesys.utils.tsprocess import choose_distribution_method

# Calculate the capacity factor distributions
method = choose_distribution_method(N_seasons, N_hours)
solar_cf = method(solarfarm_data, N_seasons, N_hours, kind='cf')
wind_cf = method(railsplitter_data, N_seasons, N_hours, kind='cf')


import numpy as np
# nuclear cost in M$/MW
years = np.linspace(start_year, end_year, N_years).astype('int')


IMP_ELC.add_regional_data(region='UIUC',
                          input_comm=ethos,
                          output_comm=electricity,
                          efficiency=1.0,
                          existing={2000:50},
                          tech_lifetime=1000,
                          cost_variable=0.1161,
                          cost_invest=0.489583,
                          cost_fixed=0.1e-3,
                          # emissions={CO2:0.000341714},
                          emissions={CO2:{2000:0.0008486,
                                          2025:0.0008486,
                                          2030:0.0,
                                          2035:0.0,
                                          2040:0.0,
                                          2045:0.0,
                                          2050:0.0}},
                          max_capacity={2025:60,
                                        # 2030:60,
                                        # 2035:60,
                                        # 2040:60,
                                        # 2045:60
                                        })

# Add regional data
# limit solar capacity to 1/4 of the total UIUC land. ~191 GW
# The University is far more land constrained than the whole State of Illinois.
SOLAR_FARM.add_regional_data(region='UIUC',
                             input_comm=ethos,
                             output_comm=electricity,
                             efficiency=1.0,
                             tech_lifetime=25,
                             loan_lifetime=10,
                             capacity_factor_tech=solar_cf,
                             existing={2016:4.86,2020:12.1},
                             emissions={co2eq:4.8e-5},
                             cost_fixed=72.51032e-3,
                             cost_invest=1.274,
                             max_capacity={2025:191,
                                           2030:191,
                                           2035:191,
                                           2040:191,
                                           2045:191,
                                           2050:191,
                                           }
                             )

WIND_FARM.add_regional_data(region='UIUC',
                            input_comm=ethos,
                            output_comm=electricity,
                            efficiency=1.0,
                            tech_lifetime=25,
                            loan_lifetime=10,
                            capacity_factor_tech=wind_cf,
                            existing={2016:8.7},
                            emissions={co2eq:1.1e-5},
                            cost_fixed=40.723e-3,
                            cost_invest=1.754,
                            max_capacity={2030:100.5,
                                          2035:100.5,
                                          2040:100.5,
                                          2045:100.5,
                                          2050:100.5})


"""
NUCLEAR_TB and ABBOTT_TB are ``dummy`` technologies that allow
thermal energy output from both a nuclear plant and natural gas plant
to be used for electricity or district heating.
"""
NUCLEAR_TB.add_regional_data(region='UIUC',
                             input_comm=nuclear_steam,
                             output_comm=electricity,
                             efficiency=0.33,
                             tech_lifetime=60,
                             )
ABBOTT_TB.add_regional_data(region='UIUC',
                            input_comm=steam,
                            output_comm=electricity,
                            efficiency=0.4,
                            tech_lifetime=40,
                            )
# Import thermal technologies
from pygenesys.technology.thermal import ABBOTT, NUCLEAR_THM, CWS

# emissions data from EIA
ABBOTT.add_regional_data(region='UIUC',
                         input_comm=ethos,
                         output_comm=steam,
                         efficiency=1.00,
                         tech_lifetime=40,
                         loan_lifetime=25,
                         capacity_factor_tech=0.57,
                         emissions={co2eq:2.395e-4, CO2:3.345e-4},
                         existing={2003:261.03},
                         # ramp_up=0.25,
                         # ramp_down=0.25,
                         cost_fixed=79.878e-3,
                         cost_invest=0.613493,
                         cost_variable=0.023009
                         )
NUCLEAR_THM.add_regional_data(region='UIUC',
                              input_comm=ethos,
                              output_comm=nuclear_steam,
                              efficiency=1.00,
                              tech_lifetime=60,
                              loan_lifetime=25,
                              capacity_factor_tech=0.93,
                              emissions={co2eq:1.2e-5},
                              ramp_up=0.25,
                              ramp_down=0.25,
                              cost_invest=5.905853,
                              cost_fixed=121.09221e-3,
                              cost_variable=0.009158,
                              )

from pygenesys.data.library import cws_data, tes_data
cws_cf = method(cws_data, N_seasons, N_hours, kind='cf')
tes_cf = method(tes_data, N_seasons, N_hours, kind='cf')

CWS.add_regional_data(region='UIUC',
                      input_comm=electricity,
                      output_comm=chilled_water,
                      efficiency=1.467,
                      tech_lifetime=40,
                      loan_lifetime=20,
                      capacity_factor_tech=0.375,
                      ramp_up=0.1978,
                      ramp_down=0.1978,
                      cost_variable=7.635,
                      cost_fixed=0.40641,
                      cost_invest=0.0018942)

# Import storage technology
from pygenesys.technology.storage import CW_STORAGE, LI_BATTERY
CW_STORAGE.add_regional_data(region='UIUC',
                             input_comm=chilled_water,
                             output_comm=chilled_water,
                             efficiency=0.95,
                             capacity_factor_tech=0.5,
                             tech_lifetime=100,
                             loan_lifetime=10,
                             ramp_up=0.5830,
                             ramp_down=0.5830,
                             cost_invest=0.0017856,
                             storage_duration=4,
                             )

LI_BATTERY.add_regional_data(region='UIUC',
                             input_comm=electricity,
                             output_comm=electricity,
                             efficiency=0.80,
                             capacity_factor_tech=0.2,
                             tech_lifetime=12,
                             loan_lifetime=5,
                             emissions={co2eq:2.32e-5},
                             cost_invest=1.608,
                             cost_fixed=25.102e-3,
                             storage_duration=4)

CO2.add_regional_limit(region='UIUC',
                       limits={2025:0.344,
                               2030:0.30,
                               2035:0.25,
                               2040:0.2,
                               2045:0.1,
                               end_year:0.0})

demands_list = [ELC_DEMAND, STM_DEMAND, CW_DEMAND]
resources_list = [electricity, steam, ethos, nuclear_steam, chilled_water]
emissions_list = [co2eq, CO2]

if __name__ == "__main__":
    import numpy as np

    horizon = np.linspace(start_year, end_year, N_years).astype('int')
    print(horizon)

    import matplotlib.pyplot as plt
    plt.style.use('ggplot')
