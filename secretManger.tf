
resource "aws_secretsmanager_secret" "student_db_secret" {
  name = "/studentApp/db-secret"
}

resource "aws_secretsmanager_secret_version" "student_db_secret_version" {
  secret_id     = aws_secretsmanager_secret.student_db_secret.id

  secret_string = jsonencode({
    url      = "jdbc:mysql://studentapp-db.cspu0y8qcrhq.us-east-1.rds.amazonaws.com:3306/studentdb"
    username = "admin"
    password = "secretepassword123"
  })

  lifecycle {
   prevent_destroy = true
 }
}
    