from web3 import Web3
from hexbytes.main import HexBytes
import configs
from filtering_types import FilteringTypes
from hex_encoder import HexJsonEncoder
import os
import json


def append_transaction(transactions: dict, transaction) -> dict:
    transactions[transaction.hash] = dict(transaction)
    return transactions
    

def filter_address_to(address: str, transactions: list[dict]) -> dict:
    filtered_trx = {}
    for transaction in transactions:
        if transaction.to == address:
            filtered_trx = append_transaction(filtered_trx, transaction)
    return filtered_trx

def filter_value_gt(amount: int, transactions: list[dict]) -> dict:
    filtered_trx = {}
    for transaction in transactions:
        if transaction.value > amount:
            filtered_trx[transaction.hash] = transaction
    return filtered_trx

def filter_value_lt(amount: int, transactions: list[dict]) -> dict:
    filtered_trx = {}
    for transaction in transactions:
        if transaction.value < amount:
            filtered_trx[transaction.hash] = transaction
    return filtered_trx

def filter_address_from(address: str, transactions: list[dict]) -> dict:
    filtered_trx = {}
    for transaction in transactions:
        if transaction['from'] == address:
            filtered_trx[transaction.hash] = transaction
    return filtered_trx


def main() -> None:
    api_key = configs.api_key
    web3 = Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/' + api_key))

    network_id = web3.net.version 
    print(f"Connected to network with ID: {network_id}")

    start_block = configs.start_block
    end_block = configs.end_block
    address = configs.address
    value = configs.value
    filtering = configs.filtering
    folder_path = configs.folder_path
    file_name = configs.file_name + '.json'
    
    transactions = {}
    for block_number in range(start_block, end_block + 1):
        block = web3.eth.get_block(block_number, full_transactions=True)
        if filtering == FilteringTypes.ADDRESS_TO:
            filtered_transactions = filter_address_to(address, block.transactions)
        elif filtering == FilteringTypes.ADDRESS_FROM:
            filtered_transactions = filter_address_from(address, block.transactions)
        elif filtering == FilteringTypes.VALUE_GT:
            filtered_transactions = filter_value_gt(value, block.transactions)
        elif filtering == FilteringTypes.VALUE_LT:
            filtered_transactions = filter_value_lt(value, block.transactions)
        else:
            print("Invalid filtering type")
            return
        transactions.update(filtered_transactions)
    
    os.makedirs(folder_path, exist_ok=True)
    file_path = os.path.join(folder_path, file_name)
    with open(file_path, 'w') as json_file:
        json.dump(list(transactions.values()), json_file, indent=4, cls=HexJsonEncoder)
        
    print(f"Dictionary exported to {file_path}")
        


if __name__ == "__main__":
    main()


