# web3

Excercise 1

If you are working with a Windows you need to download microsoft C++ Tools here https://visualstudio.microsoft.com/visual-cpp-build-tools/

And you need to follow these steps https://stackoverflow.com/questions/64261546/how-to-solve-error-microsoft-visual-c-14-0-or-greater-is-required-when-inst


pip install -r src/excercise1/requirements.txt



Inside configs.py
api_key -> This is the infuria api key (It is not a good practice to do it like this. It would have been saved in the secrets inside the cloud provider)
start_block -> Starting block inclusive
end_block -> Ending block inclusive
address -> Address being filtered
value -> Value being filtered
folder_path -> Path of folder where the output will be saved
file_name -> Name of final output file
filtering -> It can take 4 options:
- 'address_to' which filters to which address is the transaction being done
- 'address_from' which filters from which address is the transaction being done
- 'value_gt' which filters values greater than
- 'value_lt' which filters values lower than


python src/excercise1data_ingestion.py

Excercise 2

docker pull postgres