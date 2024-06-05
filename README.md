# data_insight_setup
Setup instructions to get up and running in the data science team.

1. 
  A. If you are a Windows user:
    1. open PowerShell as administrator
    2. Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    3. Write Y when prompted
    4. cd into the folder with the downloaded zip: cd C:\Users\[INSERT USER NAME]\Downloads\
    5. Expand-Archive -LiteralPath ".\data_insight_setup-main.zip"
    6. .\data_insight_setup-main\data_insight_setup-main\install_script_windows.ps1
    8. Download Leapp from https://www.leapp.cloud/releases

  B. If you are a Mac user:
    1. Download install_script_mac.sh
    2. cd into the download folder
    3. $ ./install_script_mac.sh

2. Download your favorite IDE, for example Visual Studio Code

3. $ git clone https://github.com/Airthings/stack-glue-jobs.git

4. Open the folder stack-glue-jobs/src/notebooks/dataset_battery_features in your IDE 

5. In your integrated terminal, write $ poetry install   

   
