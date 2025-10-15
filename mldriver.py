from yaml_parser.yaml_config_parser import YmlConfig
from lib.run_pipeline import RunPipeline
from lib.azure_kv import AzureSecret
from lib.logger import get_logger, log_exception, LoggerDecorator
from lib.data_drift import Datadrift


logger = get_logger(__name__)

class MlDriver(YmlConfig, RunPipeline, AzureSecret):
    """
    Class for driving the machine learning process.
    Handles the orchestration of the ML pipeline including configuration parsing,
    data loading, and pipeline execution.
    """

    def __init__(self, spark_session):
        """
        Initialize the MlDriver object with necessary components and configurations.
        
        Args:
            spark_session: Active Spark session for data processing
        """
        try:
            super().__init__()
            AzureSecret.__init__(self)
            RunPipeline.__init__(self)
            
            self.spark_session = spark_session
            self.yml_file_path = f"./yaml_files/"
            self.data_dfs = dict()
            self.external_dfs = dict()
            self.yml_config = dict()
            self.label_encoders = dict()
            self.key_client = None
            self.yml_file_name = None
            self.blob_service_client = None
            self.data_drift = Datadrift()
            logger.info("MlDriver initialized successfully")
            
        except Exception as e:
            log_exception(logger, e, "Failed to initialize MlDriver")
            raise

    @LoggerDecorator()
    def execute(self, args):
        """
        Execute the machine learning process.

        Args:
            args: Command line arguments containing pipeline configuration.
        """
        try:
            logger.info("Starting ML Driver execution")

            # Set up YAML configuration
            self.yml_file_name = str(args.yaml) + ".yaml"
            self.yml_file_path = self.yml_file_path + self.yml_file_name
            logger.info(f"Using YAML configuration from: {self.yml_file_path}")

            # Parse YAML configuration
            logger.debug("Parsing YAML configuration")
            self.yml_parser()

            self.key_client = self.get_client()

            # Initialize blob storage client
            logger.debug("Creating blob storage client")

            self.create_blob_client()
            
            # Load input data
            logger.debug("Loading input data from sources")
            self.get_inputs()
            
            # Execute ML pipeline
            logger.info("Executing ML pipeline")
            self.run_ml_pipeline()
            
            # Run post-processing steps
            logger.debug("Running post-processing steps")
            self.invoke_postprocessing()
            
            logger.info("ML Driver execution completed successfully")
            
        except Exception as e:
            log_exception(logger, e, "Error during ML Driver execution")
            raise
