-- forecast_metrics_gbm_best
CREATE TABLE IF NOT EXISTS forecast_metrics_gbm_best (
    product_id VARCHAR NOT NULL,
    x_train INTEGER NOT NULL,
    x_test INTEGER NOT NULL,
    training_start_date DATE NOT NULL,
    training_end_date DATE NOT NULL,
    testing_start_date DATE NOT NULL,
    testing_end_date DATE NOT NULL,
    predicted_train_range INTEGER[] NULL,
    actual_train_range INTEGER[] NULL,
    predicted_test_range INTEGER[] NULL,
    actual_test_range INTEGER[] NULL,
    train_mae_norm DOUBLE PRECISION NOT NULL,
    train_mse_norm DOUBLE PRECISION,
    train_zero_count INTEGER,
    test_mae_norm DOUBLE PRECISION,
    test_mse_norm DOUBLE PRECISION,
    test_zero_count INTEGER,
    forecast_mae_norm DOUBLE PRECISION,
    forecast_mse_norm DOUBLE PRECISION,
    forecast_training_time DOUBLE PRECISION,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, testing_end_date)
);

-- longterm_forecast_gbm_best
CREATE TABLE IF NOT EXISTS longterm_forecast_gbm_best (
    product_id VARCHAR NOT NULL,
    forecast_value DOUBLE PRECISION NOT NULL,
    week_seq INTEGER NOT NULL,
    week_no INTEGER NOT NULL,
    week_date DATE NOT NULL,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, week_date)
);

-- last_forecast_gbm_best
CREATE TABLE IF NOT EXISTS last_forecast_gbm_best (
    product_id VARCHAR NOT NULL,
    next_week_demand DOUBLE PRECISION NOT NULL,
    forecast_accuracy DOUBLE PRECISION NOT NULL,
    week_date DATE NOT NULL,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, week_date)
);

-- master_forecast_gbm_best
CREATE TABLE IF NOT EXISTS master_forecast_gbm_best (
    product_id VARCHAR NOT NULL,
    forecast_values DOUBLE PRECISION[] NOT NULL,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, added_at)
);

-- sku_prior_gbm_best
CREATE TABLE IF NOT EXISTS sku_prior_gbm_best (
    product_id VARCHAR NOT NULL,
    ds TIMESTAMP NOT NULL,
    y DOUBLE PRECISION,
    has_holiday BOOLEAN NOT NULL,
    has_promotion BOOLEAN NOT NULL,
    season VARCHAR NOT NULL,
    day INTEGER,
    week INTEGER,
    month INTEGER,
    quarter INTEGER,
    year INTEGER,
    lag1_demand_qty DOUBLE PRECISION,
    lag1_demand_qty_rolling_mean DOUBLE PRECISION,
    lag1_demand_qty_expanding_mean DOUBLE PRECISION,
    lag1_demand_qty_sales_acceleration DOUBLE PRECISION,
    lag1_demand_qty_fourier_transform DOUBLE PRECISION,
    lag1_demand_qty_variability DOUBLE PRECISION,
    promotion_frequency INTEGER,
    ppi_final_demand DOUBLE PRECISION,
    ppi_all DOUBLE PRECISION,
    ppi_stationery DOUBLE PRECISION,
    cpi_median DOUBLE PRECISION,
    cpi_all DOUBLE PRECISION,
    sticky_cpi DOUBLE PRECISION,
    inflation DOUBLE PRECISION,
    gdp DOUBLE PRECISION,
    unemployment_rate DOUBLE PRECISION,
    purchasing_power DOUBLE PRECISION,
    prime_rate DOUBLE PRECISION,
    fedfunds_effective_rate DOUBLE PRECISION,
    fixed_mortgage_avg_15y DOUBLE PRECISION,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, ds)
);

-- raw_data_gbm_best
CREATE TABLE IF NOT EXISTS raw_data_gbm_best (
    product_id VARCHAR NOT NULL,
    ds TIMESTAMP NOT NULL,
    y DOUBLE PRECISION,
    has_holiday BOOLEAN NOT NULL,
    has_promotion BOOLEAN NOT NULL,
    season VARCHAR NOT NULL,
    day INTEGER,
    week INTEGER,
    month INTEGER,
    quarter INTEGER,
    year INTEGER,
    lag1_demand_qty DOUBLE PRECISION,
    lag1_demand_qty_rolling_mean DOUBLE PRECISION,
    lag1_demand_qty_expanding_mean DOUBLE PRECISION,
    lag1_demand_qty_sales_acceleration DOUBLE PRECISION,
    lag1_demand_qty_fourier_transform DOUBLE PRECISION,
    lag1_demand_qty_variability DOUBLE PRECISION,
    promotion_frequency INTEGER,
    ppi_final_demand DOUBLE PRECISION,
    ppi_all DOUBLE PRECISION,
    ppi_stationery DOUBLE PRECISION,
    ppi_office_sup DOUBLE PRECISION,
    cpi_median DOUBLE PRECISION,
    cpi_all DOUBLE PRECISION,
    sticky_cpi DOUBLE PRECISION,
    inflation DOUBLE PRECISION,
    gdp DOUBLE PRECISION,
    unemployment_rate DOUBLE PRECISION,
    purchasing_power DOUBLE PRECISION,
    prime_rate DOUBLE PRECISION,
    fedfunds_effective_rate DOUBLE PRECISION,
    fixed_mortgage_avg_15y DOUBLE PRECISION,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, ds)
);

-- feature_importance_gbm_best
CREATE TABLE IF NOT EXISTS feature_importance_gbm_best (
    product_id VARCHAR NOT NULL,
    feature VARCHAR NOT NULL,
    importance DOUBLE PRECISION,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, added_at)
);

-- train_predictions_gbm_best
CREATE TABLE IF NOT EXISTS train_predictions_gbm_best (
    product_id VARCHAR NOT NULL,
    week_date DATE NOT NULL,
    predicted DOUBLE PRECISION NOT NULL,
    forecast_run_date DATE DEFAULT CURRENT_DATE,
    added_at TIMESTAMP DEFAULT NOW(),
    modified_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (product_id, week_date)
);

