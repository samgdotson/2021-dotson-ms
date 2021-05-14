import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


# plot styles
plt.rcParams['figure.figsize']=(12,9)
plt.rcParams['font.size'] = '16'
plt.rcParams['font.family'] = 'serif'
# plt.rcParams['font.usetex'] = True
plt.style.use('ggplot')

season_colors = {'spring':'tab:green',
                 'summer':'tab:red',
                 'fall':'tab:orange',
                 'winter':'tab:blue'}


def seasonal_trend(df, column, feature=None, capacity=None):
    """
    This function generates a seasonal trend from the input
    dataframe. The seasons are:
       * Summer
       * Winter
       * Fall
       * Spring
    and are assumed to be the same length, i.e. 1/4th of the year.
    The seasonal trend is an "hourly seasonal average." In other words
    a typical 24-hour trend is calculated for each season from
    the provided data.

    Parameters
    ----------
    df : Pandas DataFrame
        The dataframe that needs to be trended. The index
        must be a pandas datetime index with a frequency of
        at least 1 hour.
    column : string
        The name of the column in `df` with the data you
        wish to trend.
    feature : string
        An additional feature you wish to extract. Currently
        supported are:
           * `cf` = the capacity factor (fraction of the maximum)
           * `dist` = the fraction of the total in each slice
        A new column set of columns with `season_feature` will
        be added to the dataframe.
    capacity : float
        The system capacity. If None is given and feature is
        `cf`, the data are divided by the max of the column.
        Otherwise, divided by the capacity value provided.


    Returns
    -------
    seasonal_df : pandas DataFrame
        A dataframe holding the seasonal trends in `df.column`.
        The columns are `season`. If another feature is given,
        then columns are `season` and `season+feature`.
    """

    # set up the season masks
    spring_mask = (df.index.month >= 3) & (df.index.month <= 5)
    summer_mask = (df.index.month >= 6) & (df.index.month <= 8)
    fall_mask = (df.index.month >= 9) & (df.index.month <= 11)
    winter_mask = ((df.index.month == 12) | (df.index.month == 1)
                    | (df.index.month == 2))

    seasons = {'spring':spring_mask,
               'summer':summer_mask,
               'fall':fall_mask,
               'winter':winter_mask}

    # initialize dictionary
    seasonal_hourly_profile = {}

    for season in seasons:
        mask = seasons[season]
        season_df = df[mask]
        hours_grouped = season_df.groupby(season_df.index.hour)

        avg_hourly = np.zeros(len(hours_grouped))
        std_hourly = np.zeros(len(hours_grouped))
        for i, hour in enumerate(hours_grouped.groups):
            hour_data = hours_grouped.get_group(hour)
            avg_hourly[i] = hour_data[column].mean()
            std_hourly[i] = hour_data[column].std()

        seasonal_hourly_profile[season] = avg_hourly
        if feature is not None:
            colname = season+"_"+feature
            if feature.lower() == 'cf':
                try:
                    seasonal_hourly_profile[colname] = avg_hourly/capacity
                except:
                    seasonal_hourly_profile[colname] = (avg_hourly
                                                        /np.max(df[column]))
            elif feature.lower() == 'dist':
                seasonal_hourly_profile[colname] = (avg_hourly
                                                    /(4*avg_hourly.sum()))

    seasonal_df = pd.DataFrame(seasonal_hourly_profile)

    return seasonal_df


def plot_seasonal(seasonal_df,
                  feature=None,
                  ylabel='None',
                  xlabel='None',
                  title='None',
                  show=False,
                  save=False):
    """
    This function plots the seasonal trends and
    one additional feature, if present.
    """

    fig, ax = plt.subplots()

    for season in season_colors:
        if feature is 'dist':
            feature_key = season+"_"+feature
            ax.plot(range(24),
            seasonal_df[feature_key],
            label=season.capitalize(),
            color=season_colors[season],
            marker='o',)
        elif feature is 'cf':
            feature_key = season+"_"+feature
            ax.plot(range(24),
            seasonal_df[season],
            label=season.capitalize(),
            color=season_colors[season],
            marker='o',)
            ax2 = ax.twinx()
            ax2.plot(range(24),
                    seasonal_df[feature_key],
                    color=season_colors[season],)
        else:
            ax.plot(range(24),
            seasonal_df[season],
            label=season.capitalize(),
            color=season_colors[season],
            marker='o',)
    ax.set_xlabel(xlabel,fontsize=16)
    ax.legend(loc=(1.02,0.5),fontsize=14)
    ax.set_ylabel(ylabel,fontsize=16)
    ax.set_title(title,fontsize=16)
    ax.grid(which='minor')
    if save is not False:
        fig.savefig(save)
    if show:
        plt.show()
        return

    return fig, ax
