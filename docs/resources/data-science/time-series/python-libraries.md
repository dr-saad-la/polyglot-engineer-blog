---
title: "Python Time Series Libraries"
date: 2026-01-24
---

# Python Time Series Libraries

Curated list of Python libraries for time series analysis and forecasting.

## Statistical Methods

1. **statsmodels** - Classical statistical models: [GitHub](https://github.com/statsmodels/statsmodels) | [Docs](https://www.statsmodels.org/) ARIMA, SARIMAX, VAR, state space models, statistical tests
2. **pmdarima** - Auto-ARIMA for Python: [GitHub](https://github.com/alkaline-ml/pmdarima) |
   [Docs](http://alkaline-ml.com/pmdarima/) Automated ARIMA modeling, seasonal decomposition, scikit-learn compatible
3. **Prophet** - Facebook's forecasting tool: [GitHub](https://github.com/facebook/prophet) |
   [Docs](https://facebook.github.io/prophet/) Business forecasting with seasonality, holidays,
   changepoints

## Machine Learning

1. **sktime** - Unified ML framework [GitHub](https://github.com/sktime/sktime) | [Docs](https://www.sktime.net/) Classification, regression, forecasting, scikit-learn compatible

2. **tslearn** - Time series ML [GitHub](https://github.com/tslearn-team/tslearn) | [Docs](https://tslearn.readthedocs.io/) Clustering, classification, DTW, shapelet learning

3. **GluonTS** - Probabilistic forecasting [GitHub](https://github.com/awslabs/gluonts) | [Docs](https://ts.gluon.ai/) DeepAR, Transformer models, MXNet/PyTorch backends

4. **aeon** - ML toolkit (sktime successor) [GitHub](https://github.com/aeon-toolkit/aeon) |
   [Docs](https://www.aeon-toolkit.org/) Classification, regression, clustering, next-gen sktime

5. **pyts** - Time series classification [GitHub](https://github.com/johannfaouzi/pyts) | [Docs](https://pyts.readthedocs.io/) Imaging, shapelet transform, bag-of-words, classification

6. **PyPOTS** - Partially observed time series: [GitHub](https://github.com/WenjieDu/PyPOTS) |
   [Docs](https://pypots.com/) Imputation, forecasting, classification for incomplete data

7. **deeptime** - Dynamical systems [GitHub](https://github.com/deeptime-ml/deeptime) | [Docs](https://deeptime-ml.github.io/) Markov models, Koopman theory, molecular dynamics

## Deep Learning
1.**PyTorch Forecasting** - Neural forecasting: [GitHub](https://github.com/jdb78/pytorch-forecasting) | [Docs](https://pytorch-forecasting.readthedocs.io/) N-BEATS, TFT, DeepAR, NHiTS implementations
2. **Darts** - User-friendly forecasting [GitHub](https://github.com/unit8co/darts) | [Docs](https://unit8co.github.io/darts/) Classical + neural methods, backtesting, ensemble models
3. **NeuralProphet** - Neural Prophet [GitHub](https://github.com/ourownstory/neural_prophet) |
   [Docs](https://neuralprophet.com/) Prophet reimplemented with PyTorch, autoregression support
4. **Time-Series-Library** - SOTA models collection: [GitHub](https://github.com/thuml/Time-Series-Library) Comprehensive library: iTransformer, TimesNet, PatchTST, DLinear, etc.
5. **NeuralForecast** - Nixtla's neural methods: [GitHub](https://github.com/Nixtla/neuralforecast) | [Docs](https://nixtlaverse.nixtla.io/neuralforecast/)  RNN, LSTM, N-BEATS, N-HiTS, TFT implementations
6. **Flow Forecast** - Deep learning forecasting: [GitHub](https://github.com/AIStream-Peelout/flow-forecast) | [Docs](https://flow-forecast.atlassian.net/)  Multi-variate forecasting, transformers, deployment ready
7. **InceptionTime** - Deep learning classifier [GitHub](https://github.com/hfawaz/InceptionTime)
   SOTA time series classification with Inception architecture
8. **TimeMixer** - Mixing forecasting model: [GitHub](https://github.com/kwuking/TimeMixer)
   Multi-scale mixing for long-term forecasting

## Foundation Models

1. **Time-LLM** - LLM for time series: [GitHub](https://github.com/KimMeen/Time-LLM) Large
   language models adapted for time series forecasting

2. **Large-Time-Series-Model** - Foundation model [GitHub](https://github.com/thuml/Large-Time-Series-Model) Pre-trained model for zero-shot forecasting

## Feature Engineering

1. **tsfresh** - Automatic feature extraction [GitHub](https://github.com/blue-yonder/tsfresh) |
   [Docs](https://tsfresh.readthedocs.io/) Extract 700+ time series features automatically
2. **tsfeatures** - Feature extraction [GitHub](https://github.com/Nixtla/tsfeatures) | [PyPI](https://pypi.org/project/tsfeatures/) Fast feature computation for time series
3. **Catch22** - 22 canonical features [GitHub](https://github.com/chlubba/catch22) | [Docs](https://github.com/chlubba/catch22) Minimal feature set for classification

## Anomaly Detection

1. **stumpy** - Matrix profile [GitHub](https://github.com/TDAmeritrade/stumpy) | [Docs](https://stumpy.readthedocs.io/) Pattern discovery, anomaly detection, motif search
2. **PyOD** - Outlier detection [GitHub](https://github.com/yzhao062/pyod) | [Docs](https://pyod.readthedocs.io/) 40+ anomaly detection algorithms

## Utilities

1. **pandas** - Time series data structures [GitHub](https://github.com/pandas-dev/pandas) |
   [Docs](https://pandas.pydata.org/) DatetimeIndex, resampling, rolling windows

2. **scipy** - Signal processing [GitHub](https://github.com/scipy/scipy) | [Docs](https://scipy.org/) Filters, spectral analysis, interpolation

3. **matplotlib** - Time series plotting [GitHub](https://github.com/matplotlib/matplotlib) |
   [Docs](https://matplotlib.org/) Visualization and plotting
4. **Pathway** - Real-time data processing [GitHub](https://github.com/pathwaycom/pathway) |
   [Docs](https://pathway.com/) Streaming time series, real-time ML pipelines

---
Other tools are added regularly ...
