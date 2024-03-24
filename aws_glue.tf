
resource "aws_glue_job" "example_job" {
  name     = "example_glue_job"
  role_arn = aws_iam_role.glue_role.arn
  command {
    name            = "glueetl"
    script_location = "s3://your-bucket-name/path/to/script.py" # Change this to your script location
  }
  default_arguments = {
    "--job-language" = "python"
  }
}

# Create Glue Trigger as Schedule
resource "aws_glue_trigger" "example_trigger" {
  name          = "example_glue_trigger"
  type          = "SCHEDULED"
  workflow_name = aws_glue_job.example_job.name

  schedule = "cron(0 0 * * ? *)" # Schedule to run daily at midnight

  actions {
    job_name = aws_glue_job.example_job.name
  }
}
