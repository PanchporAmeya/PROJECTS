#!/usr/bin/env python
# coding: utf-8

# In[22]:


import numpy as np
import pandas as pd
import yfinance as yf
import matplotlib.pyplot as plt
from pypfopt import EfficientFrontier,risk_models,expected_returns,plotting,objective_functions


# Historical Data

# In[3]:


tickers = ["TCS.BO","RELIANCE.BO","INFY.BO","SBIN.BO","ITC.BO","ONGC.BO","NTPC.BO","LT.BO","HDFCBANK.BO","IRCTC.BO"]
data = yf.download(tickers,start = "2023-01-01", end = "2023-12-31")["Adj Close"]


# In[4]:


data


# Expected Returns

# In[5]:


Exp_Ret = expected_returns.mean_historical_return(data)


# In[6]:


Exp_Ret


# Covariance Matrix

# In[7]:


Cov_Mar = risk_models.sample_cov(data)


# In[8]:


Cov_Mar


# Optimizing Portfolio by calculating Maximum Sharpe Ratio

# In[39]:


EF = EfficientFrontier(Exp_Ret,Cov_Mar)
weights_max_sharpe = EF.max_sharpe()
cleaned_weights_max_sharpe = EF.clean_weights()
ret_sharpe, std_sharpe, sharpe_ratio = EF.portfolio_performance()


# Optimizing Portfolio by calculating Minimum Volatility

# In[49]:


EF = EfficientFrontier(Exp_Ret,Cov_Mar)
weights_min_vol = EF.min_volatility()
cleaned_weights_min_vol = EF.clean_weights()
ret_min_vol, std_min_vol, sharpe_ratio = EF.portfolio_performance()


# Printing the Portfolio Weights

# In[50]:


print("Maximum Sharpe Ratio Portfolio Weights:", cleaned_weights_max_sharpe)
print("Expected annual return, volatility, and Sharpe ratio:", ret_sharpe, std_sharpe, sharpe_ratio)

print("Minimum Volatility Portfolio Weights:", cleaned_weights_min_vol)
print("Expected annual return, volatility:", ret_min_vol, std_min_vol)


# Plotting Portfolio

# In[63]:


EF = EfficientFrontier(Exp_Ret,Cov_Mar)
fig, ax = plt.subplots()
plotting.plot_efficient_frontier(EF, ax=ax, show_assets=True)
ax.scatter(ret_sharpe,std_sharpe, marker="*", s=100, c="r", label="Max Sharpe")
ax.scatter(ret_min_vol,std_min_vol, marker="*", s=100, c="b", label="Min Volatility")
ax.legend()
plt.title("Efficient Frontier")
plt.xlabel("Volatility (Standard Deviation)")
plt.ylabel("Return")
plt.show()

