#!/bin/bash

mongoimport --db smkinst --collection smkinst --upsert --upsertFields id --file $1  --jsonArray
