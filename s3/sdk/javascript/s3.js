// https://github.com/aws/aws-sdk-js-v3
require('dotenv').config({ path: '../../../.env' });
const { S3Client, CreateBucketCommand, PutObjectCommand, BucketAlreadyOwnedByYou } = require('@aws-sdk/client-s3');
const fs = require('fs');
const crypto = require('crypto');

// Configuration
const bucketName = process.env.BUCKET_NAME;
const region = process.env.AWS_REGION || 'eu-west-2';

if (!bucketName) {
  console.error('Error: BUCKET_NAME environment variable is not set.');
  process.exit(1);
}

// Initialize S3 Client
const client = new S3Client({ region });

async function main() {
  try {
    // 1. Create Bucket
    try {
      console.log(`Creating bucket: ${bucketName}...`);
      await client.send(new CreateBucketCommand({
        Bucket: bucketName,
        CreateBucketConfiguration: {
          LocationConstraint: region
        }
      }));
      console.log(`Bucket ${bucketName} created.`);
    } catch (err) {
      if (err instanceof BucketAlreadyOwnedByYou || err.name === 'BucketAlreadyOwnedByYou') {
        console.log(`Bucket ${bucketName} already exists and is owned by you.`);
      } else {
        throw err;
      }
    }

    // 2. Determine number of files
    const numberOfFiles = 1 + Math.floor(Math.random() * 6);
    console.log(`number_of_files: ${numberOfFiles}`);

    // 3. Create and Upload files
    for (let i = 0; i < numberOfFiles; i++) {
      console.log(`i: ${i}`);
      const filename = `file_js_${i}.txt`;
      const filePath = `/tmp/${filename}`;
      const fileContent = crypto.randomUUID();

      // Write local file
      fs.writeFileSync(filePath, fileContent);

      // Upload to S3
      const fileStream = fs.createReadStream(filePath);
      await client.send(new PutObjectCommand({
        Bucket: bucketName,
        Key: filename,
        Body: fileStream
      }));
    }

    console.log('Uploads complete.');

  } catch (err) {
    console.error('Error:', err);
  }
}

main();
