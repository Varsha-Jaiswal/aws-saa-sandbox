Import-Module AWS.Tools.S3

$bucketName = Read-Host -Prompt "Enter the bucket name"
$region = Read-Host -Prompt "Enter the region"

Write-Host "Creating bucket $bucketName in region $region"

New-S3Bucket -BucketName $bucketName -Region $region

Write-Host "Bucket created successfully"
