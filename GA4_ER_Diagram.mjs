
erDiagram
    BikeTheft {
        int ID PK
        int OBJECTID
        int Year
        date ReportedDate
        date OccurredDate
        string DayOfWeek
        string OffenceCategory
        string BicycleStyle
        float BicycleValue
        string BicycleMake
        string BicycleType
        string BicycleFrame
        string BicycleColour
        int BicycleSpeed
        int NeighbourhoodID FK
    }

    CriminalOffence {
        int OBJECTID PK
        int Year
        date ReportedDate
        int ReportedHour
        date OccurrenceDate
        int OccurrenceHour
        string Weekday
        string OffenceSummary
        string OffenceCategory
        int NeighbourhoodID FK
    }

    Neighbourhood {
        int NeighbourhoodID PK
        string Neighbourhood
        string Sector
        string Division
        string CensusTract
        float x
        float y
    }

    BikeTheft ||--o{ Neighbourhood: "belongs to"
    CriminalOffence ||--o{ Neighbourhood: "occurs in"
