# Atlanta Geo Data

This folder contains information on Geo Data in City of Atlanta

## Geographic Hierarchy

Diagram inspired by [US Census Geographic Hierarchy](https://www2.census.gov/geo/pdfs/reference/geodiagram.pdf), showing parent/child relationships

The [mermaid](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/) code below is intended to be viewed on GitHub in a web browser

```mermaid
graph TD;
    Parcel_Address["Parcel/Address"]
    Neighborhood["Neighborhood"]
    NPU["NPU"]
    CityCouncilPrecinct["City Council Precinct"]
    CityCouncilDistrict["City Council District"]
    CensusBlock["Census Block"]
    BlockGroup["Block Group"]
    Tract["Tract"]
    County["County"]
    City_Atlanta["City (Atlanta)"]

    Neighborhood --> Parcel_Address;
    NPU --> Neighborhood;
    City_Atlanta --> NPU;

    CityCouncilPrecinct --> Parcel_Address;
    CityCouncilDistrict --> CityCouncilPrecinct;
    City_Atlanta --> CityCouncilDistrict;

    CensusBlock --> Parcel_Address;
    BlockGroup --> CensusBlock;
    Tract --> BlockGroup;
    County --> Tract;
    City_Atlanta;
```