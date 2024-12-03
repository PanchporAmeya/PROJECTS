#!/usr/bin/env python
# coding: utf-8

# In[97]:


import pandas as pd
from pypfopt.efficient_frontier import EfficientFrontier
from pypfopt import risk_models
from pypfopt import expected_returns
from pypfopt import BlackLittermanModel
from pypfopt import black_litterman
import yfinance as yf
import seaborn as sns


# In[98]:


tickers = ['TCS.BO','RELIANCE.BO','SBIN.BO','HINDUNILVR.BO','AUROPHARMA.NS','BSOFT.NS','SUNPHARMA.NS','TATAMOTORS.NS','TATAPOWER.NS','LT.BO','HDFCBANK.BO','INFY.BO','ONGC.BO','NTPC.NS','ITC.NS','IRCTC.NS']
df = yf.download(tickers, start = '2023-01-01', end = '2023-12-31')["Adj Close"]


# In[99]:


mu = expected_returns.mean_historical_return(df)
S = risk_models.sample_cov(df)


# In[100]:


mu


# In[103]:


S = risk_models.CovarianceShrinkage(df).ledoit_wolf()

delta = black_litterman.market_implied_risk_aversion(df)
delta


# In[105]:


S


# In[104]:


sns.heatmap(S.corr())


# In[77]:


ef = EfficientFrontier(mu, S)


# In[78]:


weights = ef.max_sharpe()
cleaned_weights = ef.clean_weights()
print("Optimal Weights:", cleaned_weights)


# In[106]:


pd.Series(weights).plot.pie(figsize=(9,9));


# In[79]:


from pypfopt import objective_functions

ef = EfficientFrontier(mu, S)
ef.add_objective(objective_functions.L2_reg, gamma=0.1)
weights = ef.max_sharpe()
print(ef.clean_weights())


# In[80]:


performance = ef.portfolio_performance(verbose=True)


# In[81]:


from pypfopt import plotting
import matplotlib.pyplot as plt


# In[86]:


ef = EfficientFrontier(mu, S)
fig, ax = plt.subplots()
plotting.plot_efficient_frontier(ef, ax=ax, show_tickers=True)
plt.title("Efficient Frontier")
plt.xlabel("Volatility (Standard Deviation)")
plt.ylabel("Expected Return")
plt.show()


# In[88]:


from pypfopt.discrete_allocation import DiscreteAllocation, get_latest_prices

latest_prices = get_latest_prices(df)
da = DiscreteAllocation(weights, latest_prices, total_portfolio_value=100000)
allocation, leftover = da.lp_portfolio()
print(allocation)
print(leftover)

