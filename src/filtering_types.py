from enum import Enum


class FilteringTypes(str, Enum):
    ADDRESS_TO = 'address_to'
    ADDRESS_FROM = 'address_from'
    VALUE_GT = 'value_gt'
    VALUE_LT = 'value_lt'