Import-Module AWS.Tools.S3

# Create a file and set its content
# $fileName = 'index.html'
# Set-Content -Path $fileName -Value 'My File Content'

$bucketName = Read-Host -Prompt "Enter the bucket name"
$fileName = Read-Host -Prompt "Enter the file name" # can pass the full path of the file

function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue 
    return $null -ne $bucket
}

if (-not (BucketExists)) {
    Write-Host "Bucket $bucketName does not exist"
    New-S3Bucket -BucketName $bucketName -Region "eu-west-2"
}

Write-Host "Uploading file $fileName to bucket $bucketName"

Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName

Write-Host "File uploaded successfully"