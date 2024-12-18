
erDiagram
Criminal_Master{
    int Object_ID PK
    int Theft_ID FK
    int Year
    date ReportedDate
    string ReportedHour
    date OccurredDate
    string OccurrenceHore
    string DayOfWeek
    string OffenseSummary
    string OffenseCategory
    string Neighbourhood
    string Sector
    string Division
    string CensusTract
    string x
    string y
  }

  Criminal_Detail{
    int Theft_ID PK
    string BicycleStyle
    int BicycleValue
    string BicycleMake
    string BicycleModel
    string BicycleType
    string BicycleFrame
    string BicycleColour
    string BicycleSpeed
  }

  Criminal_Detail ||-- |{ Criminal_Master: " "
