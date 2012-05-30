<!-- http://en.wikipedia.org/wiki/Comma-separated_values -->
# Spreader [![Build Status](https://secure.travis-ci.org/ahcarpenter/spreader.png?branch=master)][travis]

[travis]: http://travis-ci.org/ahcarpenter/spreader

## Installation
```spreader``` can be installed via the execution of the following command:
```
gem install spreader
```

## Usage
Given an XML file containing one node formatted in the following manner:
```xml
<coordinates>longitude_in_decimal_degrees,latitude_in_decimal_degrees[, altitude_in_decimal_degrees]</coordinates>
```
The method call is thus:
```ruby
Spreader.seed(path_to_xml, model_name, latitude_field_name, longitude_field_name)
```
Given an XML file containing nodes formatted in the following manner:
```xml
<arbitrary_node_name>
	<coordinates>longitude_in_decimal_degrees,latitude_in_decimal_degrees[, altitude_in_decimal_degrees]</coordinates>
	<coordinates>longitude_in_decimal_degrees,latitude_in_decimal_degrees[, altitude_in_decimal_degrees]</coordinates>
<arbitrary_node_name>
```
The method call is thus:
```ruby
Spreader.seed(path_to_xml, model_name, latitude_field_name, longitude_field_name)
```
Given a newline delimited CSV file containing one or more lines formatted in the following manner:
```
longitude_in_decimal_degrees,latitude_in_decimal_degrees
```
The method call is thus:
```ruby
Spreader.seed(path_to_csv, model_name, latitude_field_name, longitude_field_name)
```