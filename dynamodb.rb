module DynamoDB
require 'yaml'
require 'aws-sdk'

PARAMS =  YAML.load_file('config.yml')['aws_config']

::AWS.config(dynamo_db_endpoint: PARAMS['dynamo_db_endpoint'])

DynamoDB = AWS::DynamoDB.new(
    :access_key_id => PARAMS['access_key_id'],
    :secret_access_key => PARAMS['secret_access_key'])
end
