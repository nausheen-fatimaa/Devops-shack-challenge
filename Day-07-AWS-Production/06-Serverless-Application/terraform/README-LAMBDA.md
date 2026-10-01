# Lambda packaging

This project includes a prebuilt `lambda.zip` in the generated bundle so Terraform can apply without requiring a local packaging tool. If you edit `lambda_function.py`, recreate the zip with: `python -c "import zipfile; z=zipfile.ZipFile('lambda.zip','w'); z.write('lambda_function.py'); z.close()"`.
