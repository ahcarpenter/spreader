# Spreader [![Build Status](https://secure.travis-ci.org/ahcarpenter/spreader.png?branch=master)][travis]

[travis]: http://travis-ci.org/ahcarpenter/spreader

## Installation
`spreader` can be installed via the following command:
	<p>`gem install spreader`

## Usage
Given an XML file containing one or more nodes formatted in the following manner:
<p>
```xml
<coordinates>longitude_in_decimal_degrees,latitude_in_decimal_degrees{, altitude_in_decimal_degrees}</coordinates>
```
<br><br>The method call is as follows:
<p>
```ruby
Spreader.seed(path_to_xml, model_name, latitude_field_name, longitude_field_name)
```