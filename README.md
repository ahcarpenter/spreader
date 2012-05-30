<!-- http://en.wikipedia.org/wiki/Comma-separated_values -->
# Spreader [![Build Status](https://secure.travis-ci.org/ahcarpenter/spreader.png?branch=master)][travis]

[travis]: http://travis-ci.org/ahcarpenter/spreader

## Installation
```spreader``` can be installed via the execution of the following command:
```
gem install spreader
```

## Usage
Given an XML file containing one or more nodes formatted in the following manner:
```xml
<coordinates>longitude_in_decimal_degrees,latitude_in_decimal_degrees[, altitude_in_decimal_degrees]</coordinates>
```
The method call is as follows:
```ruby
Spreader.seed(path_to_xml, model_name, latitude_field_name, longitude_field_name)
```
Given a newline delimited CSV file containing one or more lines formatted in the following manner:
```
longitude_in_decimal_degrees,latitude_in_decimal_degrees
```
The method call is as follows:
```ruby
Spreader.seed(path_to_csv, model_name, latitude_field_name, longitude_field_name)
```