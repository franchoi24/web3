from web3 import Web3
from hexbytes.main import HexBytes

def filter_address_to(address: str, transactions: list[dict]) -> dict:
    filtered_trx = {}
    for transaction in transactions:
        if transaction.to == address:
            filtered_trx[transaction.hash] = transaction
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
    api_key = '2ea03e2b244349bebd07dfd929582896'
    web3 = Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/' + api_key))

    network_id = web3.net.version 
    print(f"Connected to network with ID: {network_id}")


    start_block = 20430000
    end_block = 20430009
    address = '0x974CaA59e49682CdA0AD2bbe82983419A2ECC400'
    transactions = {}
    for block_number in range(start_block, end_block + 1):
        block = web3.eth.get_block(block_number, full_transactions=True)
        filtered_transactions = filter_address_to(address, block.transactions)
        transactions.update(filtered_transactions)
    
    print(len(transactions))
        


if __name__ == "__main__":
    main()


