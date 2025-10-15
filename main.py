from lib.logger import get_logger, log_exception, LoggerDecorator
import configparser
from driver.mldriver import MlDriver
import warnings
import argparse
from pyspark.sql import SparkSession
import os
import sys

# Initialize logger
logger = get_logger(__name__)

os.environ['PYSPARK_PYTHON'] = sys.executable
os.environ['PYSPARK_DRIVER_PYTHON'] = sys.executable

# Suppress warnings
warnings.filterwarnings("ignore", category=Warning)

@LoggerDecorator()
def initialize_spark():
    """Initialize and return a Spark session with required configurations"""
    try:
        spark_session = SparkSession.builder \
            .config("spark.sql.execution.arrow.pyspark.enabled", "false") \
            .getOrCreate()
        logger.info("Spark session initialized successfully")
        logger.debug(f"Spark config - arrow.pyspark.enabled: {spark_session.conf.get('spark.sql.execution.arrow.pyspark.enabled')}")
        return spark_session
    except Exception as e:
        log_exception(logger, e, "Failed to initialize Spark session")
        raise

@LoggerDecorator()
def parse_arguments():
    """Parse and validate command line arguments"""
    try:
        logger.debug(f"Raw arguments passed to the script: {sys.argv}")
        parser = argparse.ArgumentParser()
        parser.add_argument("--yaml", type=str, required=True, help='yaml file name')
        args = parser.parse_args()
        logger.info(f"Arguments parsed successfully. YAML file: {args.yaml}")
        return args
    except Exception as e:
        log_exception(logger, e, "Failed to parse command line arguments")
        raise

@LoggerDecorator()
def main():
    """Main entry point of the ML pipeline"""
    try:
        # Parse arguments
        args = parse_arguments()
        
        # Initialize Spark session
        spark_session = initialize_spark()
        
        logger.info("Starting ML Pipeline execution")
        
        # Initialize MlDriver and execute with provided arguments
        driver = MlDriver(spark_session)
        driver.execute(args)
        
        logger.info("ML Pipeline execution completed successfully")
        
    except Exception as e:
        log_exception(logger, e, "Critical error in ML Pipeline execution")
        sys.exit(1)

if __name__ == "__main__":
    main()