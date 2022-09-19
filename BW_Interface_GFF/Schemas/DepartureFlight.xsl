<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns2="http://www.iata.org/IATA/2007/00" xmlns:ns="http://www.sita.aero/ams6-xml-api-datatypes" xmlns:ns1="http://www.sita.aero/ams6-xml-api-messages" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns:ns3="http://fcs2.changiairport.com">
    <xsl:template match="/">
        <ns2:IATA_AIDX_FlightLegNotifRQ>
            <xsl:attribute name="SequenceNmbr">
                <xsl:value-of select="1"/>
            </xsl:attribute>
            <xsl:if test="ns1:Envelope/@timestamp">
                <xsl:attribute name="TimeStamp">
                    <xsl:value-of select="ns1:Envelope/@timestamp"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="Version">
                <xsl:value-of select="16.1"/>
            </xsl:attribute>
            <ns2:Originator>
                <xsl:attribute name="CompanyShortName">
                    <xsl:value-of select="'FCS2'"/>
                </xsl:attribute>
            </ns2:Originator>
            <ns2:FlightLeg>
                <ns2:LegIdentifier>
                    <ns2:Airline>
                        <xsl:attribute name="CodeContext">
                            <xsl:value-of select="'3'"/>
                        </xsl:attribute>
                        <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirlineDesignator[@codeContext='IATA']"/>
                    </ns2:Airline>
                    <ns2:FlightNumber>
                        <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:FlightNumber"/>
                    </ns2:FlightNumber>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='suffix']">
                        <ns2:OperationalSuffix>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='suffix']"/>
                        </ns2:OperationalSuffix>
                    </xsl:if>
                    <ns2:DepartureAirport>
                        <xsl:attribute name="CodeContext">
                            <xsl:value-of select="'3'"/>
                        </xsl:attribute>
                        <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirportCode[@codeContext='IATA']"/>
                    </ns2:DepartureAirport>
                    <ns2:ArrivalAirport>
                        <xsl:attribute name="CodeContext">
                            <xsl:value-of select="'3'"/>
                        </xsl:attribute>
                        <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Route/ns:ViaPoints/ns:RouteViaPoint[@sequenceNumber=0]/ns:AirportCode[@codeContext='IATA']"/>
                    </ns2:ArrivalAirport>
                    <ns2:OriginDate>
                        <xsl:value-of select="xsd:date('2000-01-01')"/>
                    </ns2:OriginDate>
                </ns2:LegIdentifier>
                <ns2:LegData>
                    <ns2:OperationalStatus>
                        <xsl:attribute name="CodeContext">
                            <xsl:value-of select="'9750'"/>
                        </xsl:attribute>
                        <xsl:value-of select="'BST'"/>
                    </ns2:OperationalStatus>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='serviceType']">
                        <ns2:ServiceType>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='serviceType']"/>
                        </ns2:ServiceType>
                    </xsl:if>
                    <ns2:SpecialEmphasis>
                        <xsl:value-of select="if(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='vip']='true') then 'VIP' else ''"/>
                    </ns2:SpecialEmphasis>
                    <ns2:CabinClass>
                        <xsl:attribute name="Class">
                            <xsl:value-of select="'1'"/>
                        </xsl:attribute>
                        <ns2:SeatCapacity>
                            <xsl:value-of select="xsd:integer(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='seatsFirst'])"/>
                        </ns2:SeatCapacity>
                    </ns2:CabinClass>
                    <ns2:CabinClass>
                        <xsl:attribute name="Class">
                            <xsl:value-of select="'2'"/>
                        </xsl:attribute>
                        <ns2:SeatCapacity>
                            <xsl:value-of select="xsd:integer(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='seatsBusiness'])"/>
                        </ns2:SeatCapacity>
                    </ns2:CabinClass>
                    <ns2:CabinClass>
                        <xsl:attribute name="Class">
                            <xsl:value-of select="'3'"/>
                        </xsl:attribute>
                        <ns2:SeatCapacity>
                            <xsl:value-of select="xsd:integer(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='seatsEcon'])"/>
                        </ns2:SeatCapacity>
                    </ns2:CabinClass>
                    <ns2:CodeShareInfo>
                        <ns2:Airline>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'3'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[1]/ns:AirlineDesignator[@codeContext='IATA']"/>
                        </ns2:Airline>
                        <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[1]/ns:FlightNumber">
                            <ns2:FlightNumber>
                                <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[1]/ns:FlightNumber"/>
                            </ns2:FlightNumber>
                        </xsl:if>
                    </ns2:CodeShareInfo>
                    <ns2:AssociatedFlightLegAircraft>
                        <ns2:Airline>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'3'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:LinkedFlight/ns:FlightId/ns:AirlineDesignator[@codeContext='IATA']"/>
                        </ns2:Airline>
                        <ns2:FlightNumber>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:LinkedFlight/ns:FlightId/ns:FlightNumber"/>
                        </ns2:FlightNumber>
                        <ns2:DepartureAirport>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'3'"/>
                            </xsl:attribute>
                            <xsl:value-of select="'ZZZ'"/>
                        </ns2:DepartureAirport>
                        <ns2:ArrivalAirport>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:LinkedFlight/ns:FlightId/ns:AirportCode[@codeContext='IATA']"/>
                        </ns2:ArrivalAirport>
                        <ns2:OriginDate>
                            <xsl:value-of select="xsd:date('2022-02-17')"/>
                        </ns2:OriginDate>
                    </ns2:AssociatedFlightLegAircraft>
                    <ns2:AssociatedFlightLegSchedule>
                        <ns2:DepartureAirport>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'3'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Route/ns:ViaPoints/ns:RouteViaPoint[@sequenceNumber=0]/ns:AirportCode[@codeContext='IATA']"/>
                        </ns2:DepartureAirport>
                        <ns2:ArrivalAirport>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'3'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Route/ns:ViaPoints/ns:RouteViaPoint[@sequenceNumber=1]/ns:AirportCode[@codeContext='IATA']"/>
                        </ns2:ArrivalAirport>
                    </ns2:AssociatedFlightLegSchedule>
                    <ns2:RemarkTextCode>
                        <xsl:attribute name="CodeContext">
                            <xsl:value-of select="'9750'"/>
                        </xsl:attribute>
                        <xsl:attribute name="Qualifier">
                            <xsl:value-of select="'GTE'"/>
                        </xsl:attribute>
                        <xsl:value-of select="'BST'"/>
                    </ns2:RemarkTextCode>
                    <ns2:AirportResources>
                        <xsl:attribute name="Usage">
                            <xsl:value-of select="'Actual'"/>
                        </xsl:attribute>
                        <ns2:Resource>
                            <xsl:attribute name="DepartureOrArrival">
                                <xsl:value-of select="'Departure'"/>
                            </xsl:attribute>
                            <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='stand']">
                                <ns2:AircraftParkingPosition>
                                    <xsl:attribute name="Qualifier">
                                        <xsl:value-of select="'Remote'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='stand']"/>
                                </ns2:AircraftParkingPosition>
                            </xsl:if>
                            <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gate']">
                                <ns2:PassengerGate>
                                    <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gate']"/>
                                </ns2:PassengerGate>
                            </xsl:if>
                            <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='runway']">
                                <ns2:Runway>
                                    <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='runway']"/>
                                </ns2:Runway>
                            </xsl:if>
                            <ns2:AircraftTerminal>
                                <xsl:value-of select="xsd:token(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='aircraftTerminalCode'])"/>
                            </ns2:AircraftTerminal>
                            <ns2:PublicTerminal>
                                <xsl:value-of select="xsd:token(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='passengerTerminalCode'])"/>
                            </ns2:PublicTerminal>
                        </ns2:Resource>
                    </ns2:AirportResources>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:ScheduledDate">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'OFB'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'SCT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:ScheduledDate"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='eobt']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'OFB'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'EST'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='eobt']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gateOpen']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'GTO'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gateOpen']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='boarding']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'BST'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='boarding']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='lastCall']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'BEN'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='lastCall']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='finalCall']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'FCT'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='finalCall']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gateClosed']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'GCL'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gateClosed']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='tobt']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'OFB'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'TAR'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='tobt']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='tsat']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'SAT'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'TAR'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='tsat']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='aobt']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'OFB'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='aobt']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='atot']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'TKO'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='atot']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='ctot']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'TKO'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'CAL'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='ctot']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='ttot']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'TKO'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'TAR'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='ttot']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='asat']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'SAT'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='asat']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='asrt']">
                        <ns2:OperationTime>
                            <xsl:attribute name="CodeContext">
                                <xsl:value-of select="'9750'"/>
                            </xsl:attribute>
                            <xsl:attribute name="OperationQualifier">
                                <xsl:value-of select="'SAT'"/>
                            </xsl:attribute>
                            <xsl:attribute name="TimeType">
                                <xsl:value-of select="'ACT'"/>
                            </xsl:attribute>
                            <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='asrt']"/>
                        </ns2:OperationTime>
                    </xsl:if>
                    <ns2:AircraftInfo>
                        <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:AircraftType/ns:AircraftTypeId/ns:AircraftTypeCode[@codeContext='ICAO']">
                            <ns2:AircraftType>
                                <xsl:attribute name="CodeContext">
                                    <xsl:value-of select="'3'"/>
                                </xsl:attribute>
                                <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:AircraftType/ns:AircraftTypeId/ns:AircraftTypeCode[@codeContext='ICAO']"/>
                            </ns2:AircraftType>
                        </xsl:if>
                        <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:AircraftType/ns:AircraftTypeId/ns:AircraftTypeCode[@codeContext='IATA']">
                            <ns2:AircraftSubType>
                                <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:AircraftType/ns:AircraftTypeId/ns:AircraftTypeCode[@codeContext='IATA']"/>
                            </ns2:AircraftSubType>
                        </xsl:if>
                        <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Aircraft/ns:AircraftId/ns:Registration">
                            <ns2:Registration>
                                <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Aircraft/ns:AircraftId/ns:Registration"/>
                            </ns2:Registration>
                        </xsl:if>
                        <xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='callsign']">
                            <ns2:CallSign>
                                <xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='callsign']"/>
                            </ns2:CallSign>
                        </xsl:if>
                    </ns2:AircraftInfo>
                </ns2:LegData>
                <ns2:TPA_Extension>
                    <ns3:FlightExtensions>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'scheduleDate'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:ScheduledTime"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'standScheduled'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='standScheduled']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'gateScheduled'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gateScheduled']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'checkInRow'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='checkinRow']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'mcdt'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='mcdt']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'prevAircraftParkingPosition'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='standPrevious']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'prevPassengerGate'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='gatePrevious']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightNature'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='nature']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightisActive'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='isActive']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_pax'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_pax']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_ramp'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_ramp']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_tech'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_tech']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_catering'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_catering']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_fuel'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_fuel']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_bag'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='handler_bag']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'checkInInfo'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='checkInInfo']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'checkInRole'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='checkInRole']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'checkInTypeCode'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='checkInTypeCode']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'remark'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='remark']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'remarkType'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='remarkType']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'AirlineTerminal'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='airlineTerminalCode']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightTerminal'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='terminal']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'BusIsRequired'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='busIsRequired']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'isGeneralAviationFlight'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='isGeneralAviationFlight']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'nextStand'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='nextStand']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'TotalSeatCapacity'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='seatCapacity']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'CargoCapacity'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='cargoCapacity']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'flightStatus'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='flightStatus']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'sid'"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Value[@propertyName='sid']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="concat('ICAO','.','Airline','.',ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirlineDesignator[@codeContext='IATA'])"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirlineDesignator[@codeContext='ICAO']"/>
						</ns3:Value>
						<xsl:if test="count(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare)>=1">
							<xsl:if test="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[position()=last()]/ns:AirlineDesignator[@codeContext=&quot;ICAO&quot;]">
								<ns3:Value>
									<xsl:attribute name="propertyName">
										<xsl:value-of select="concat(&quot;ICAO.&quot;,&quot;Airline.&quot;,(ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[last()]/ns:AirlineDesignator[@codeContext='IATA']))"/>
									</xsl:attribute>
									<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:CodeShares/ns:CodeShare[position()=last()]/ns:AirlineDesignator[@codeContext=&quot;ICAO&quot;]"/>
								</ns3:Value>
							</xsl:if>
						</xsl:if>
						<xsl:for-each select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightState/ns:Route/ns:ViaPoints/ns:RouteViaPoint">
							<xsl:if test="ns:AirportCode[@codeContext='ICAO']">
								<ns1:Value>
									<xsl:attribute name="propertyName">
										<xsl:value-of select="concat('ICAO','.','Airport','.',ns:AirportCode[@codeContext='IATA'])"/>
									</xsl:attribute>
									<xsl:value-of select="ns:AirportCode[@codeContext='ICAO']"/>
								</ns1:Value>
							</xsl:if>
						</xsl:for-each>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="concat('ICAO','.','Airline','.',ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirportCode[@codeContext='IATA'])"/>
							</xsl:attribute>
							<xsl:value-of select="ns1:Envelope/ns1:Content/ns1:FlightUpdatedNotification/ns1:Flight/ns:FlightId/ns:AirportCode[@codeContext='ICAO']"/>
						</ns3:Value>
					</ns3:FlightExtensions>
                </ns2:TPA_Extension>
            </ns2:FlightLeg>
        </ns2:IATA_AIDX_FlightLegNotifRQ>
    </xsl:template>
</xsl:stylesheet>