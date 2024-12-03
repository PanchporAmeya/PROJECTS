#!/usr/bin/env python
# coding: utf-8

# In[2]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import yfinance as yf


# In[3]:


assets = ['TCS.NS','RELIANCE.NS','SBIN.NS','ONGC.NS','LT.NS']
df = yf.download(assets, start = '2024-01-01', end = '2024-10-31')['Adj Close']


# In[4]:


returns = df.pct_change()


# In[5]:


returns.dropna(inplace=True)


# In[38]:


no_of_portfolios = 1000


# In[39]:


pf_returns = []
pf_risks = []
pf_weights = []
pf_sharpe_ratio = []
RF = 0.068


# In[40]:


for portfolios in range (no_of_portfolios):
    weights = np.random.random_sample(len(assets))
    weights = np.round((weights/np.sum(weights)),3)
    pf_weights.append(weights)
    annualized_returns = np.sum(returns.mean() * weights) * 252
    pf_returns.append(annualized_returns)
    var = np.dot(weights.T,np.dot(returns.cov(), weights)) * 252
    pf_std = np.sqrt(var)
    pf_risks.append(pf_std)
    sharpe_ratio = (annualized_returns - RF)/pf_std
    pf_sharpe_ratio.append(sharpe_ratio)


# In[41]:


pf_weights


# In[42]:


pf_returns


# In[43]:


pf_risks


# In[44]:


pf_sharpe_ratio


# In[45]:


portfolio_returns = np.array(pf_returns)
portfolio_risk = np.array(pf_risks)
sharpe_ratios = np.array(pf_sharpe_ratio)


# In[46]:


portfolio_metrics = [portfolio_returns, portfolio_risk, sharpe_ratios, pf_weights]


# In[47]:


portfolio_df = pd.DataFrame(portfolio_metrics).T
portfolio_df.columns = ['Risk','Return','Sharpe Ratio','Weights']
print(portfolio_df)


# In[48]:


min_risk = portfolio_df.iloc[portfolio_df['Risk'].astype(float).idxmin()]


# In[49]:


print('Lowest Risk')
print(min_risk)
print(assets)
print('')


# In[50]:


max_returns = portfolio_df.iloc[portfolio_df['Return'].astype(float).idxmax()]


# In[51]:


print('Maximun Returns')
print(max_returns)
print(assets)
print('')


# In[52]:


max_sharpe = portfolio_df.iloc[portfolio_df['Sharpe Ratio'].astype(float).idxmax()]


# In[53]:


print('Maximum Risk Adjusted Returns')
print(max_sharpe)
print(assets)
print('')


# In[56]:


plt.figure(figsize = (10,6))
plt.scatter(portfolio_risk, portfolio_returns, c = sharpe_ratios)
plt.title('Portfolio Optimization', fontsize = 20)
plt.xlabel('Volatility', fontsize = 20)
plt.ylabel('Returns', fontsize = 20)
plt.xticks(fontsize = 15)
plt.yticks(fontsize = 15)
plt.colorbar(label = 'Sharpe Ratio')
plt.show()

