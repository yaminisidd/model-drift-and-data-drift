import traceback
import yaml
from lib.logger import get_logger, log_exception, LoggerDecorator

logger = get_logger(__name__)

class YmlConfig:
    """
    Class for parsing and handling YAML configuration files.
    Provides functionality to read, parse and validate YAML files.
    """

    def __init__(self):
        """Initialize YmlConfig class."""
        pass

    @LoggerDecorator()
    def yml_parser(self):
        """
        Parse YAML configuration file and load its contents.

        Returns:
            dict: Parsed YAML configuration
        
        Raises:
            FileNotFoundError: If the YAML file is not found
            yaml.YAMLError: If there's an error parsing the YAML content
            Exception: For other unexpected errors
        """
        try:
            logger.info("Starting YAML content parsing")
            logger.debug(f"Reading YAML file from: {self.yml_file_path}")
            
            with open(self.yml_file_path, "r") as f:
                yaml_content = f.read()
                # Environment variable substitution can be added here if needed
                # for key, value in self.env_vals.items():
                #     yaml_content = yaml_content.replace(
                #         "${" + str(key) + "}", os.getenv(key)
                #     )
                
                self.yml_config = yaml.safe_load(yaml_content)
                logger.info("YAML content parsed successfully")
                return self.yml_config
                
        except FileNotFoundError as e:
            log_exception(logger, e, f"YAML file not found: {self.yml_file_path}")
            raise
        except yaml.YAMLError as e:
            log_exception(logger, e, "Error parsing YAML content")
            raise
        except Exception as e:
            log_exception(logger, e, "Unexpected error during YAML parsing")
            raise

    @LoggerDecorator()
    def is_key_present(self, yaml_file, key):
        """
        Check if a specific key exists in the YAML file.

        Args:
            yaml_file (str): Path to the YAML file
            key (str): Key to check for

        Returns:
            bool: True if key exists, False otherwise
        """
        try:
            logger.debug(f"Checking for key '{key}' in file: {yaml_file}")
            
            with open(yaml_file, "r") as file:
                data = yaml.safe_load(file)
                
            key_exists = key in data
            logger.debug(f"Key '{key}' {'found' if key_exists else 'not found'} in YAML file")
            return key_exists
            
        except FileNotFoundError as e:
            log_exception(logger, e, f"YAML file not found: {yaml_file}")
            return False
        except yaml.YAMLError as e:
            log_exception(logger, e, f"Error parsing YAML file: {yaml_file}")
            return False
        except Exception as e:
            log_exception(logger, e, "Unexpected error during key validation")
            return False
