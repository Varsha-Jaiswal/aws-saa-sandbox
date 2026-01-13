# Required libraries
require 'aws-sdk-s3'  # AWS SDK for S3 operations
require 'dotenv'
Dotenv.load(File.join(File.dirname(__FILE__), '../../../.env')) # load env variables from .env
require 'securerandom' # For generating secure random strings (UUIDs)

# S3 Bucket configuration
bucket_name = ENV['BUCKET_NAME']  # Fetching bucket name from environment variables
region = 'eu-west-2'           # AWS region where the bucket will be created

# Initialize AWS S3 client
client = Aws::S3::Client.new      # Creating a new instance of the S3 client

# Create S3 bucket
# Note: create_bucket is idempotent, but will fail if region doesn't match or permissions issue.
# We wrap in rescue specifically for bucket ownership checks if needed, but simple create is fine for now.
begin
  resp = client.create_bucket({
    bucket: bucket_name,            # Name of the bucket
    create_bucket_configuration: {
      location_constraint: region   # Region for the bucket
    }
  })
rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
  # Bucket already exists and is owned by us, proceed.
  puts "Bucket #{bucket_name} already exists."
end

# Determine the number of files to create and upload
number_of_files = 1 + rand(6)     # Generating a random number between 1 and 6
puts "number_of_files: #{number_of_files}"

# Loop to create and upload each file
number_of_files.times.each do |i|
  puts "i: #{i}"
  filename = "file_#{i}.txt"      # Generating a filename for each file
  output_path = "/tmp/#{filename}"# Specifying the output path for the file

  # Writing a unique UUID to each file
  File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)    # Write a random UUID to the file
  end

  # Open and read the file in binary mode, then upload it to S3
  File.open(output_path, 'rb') do |f|  # 'rb' mode for reading binary data
    client.put_object(                # Uploading the file to S3
      bucket: bucket_name,            # Bucket to upload to
      key: filename,                  # Key (filename) for the object in the bucket
      body: f                         # File content
    )
  end
end