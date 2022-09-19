<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns1="http://www.sita.aero/ams6-xml-api-datatypes" xmlns:ns2="http://www.sita.aero/ams6-xml-api-messages" xmlns:ns="http://www.iata.org/IATA/2007/00" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns:ns3="http://fcs2.changiairport.com">
	<xsl:template match="/">
		<ns:IATA_AIDX_FlightLegNotifRQ>
			<xsl:attribute name="Version">
				<xsl:value-of select="16.1"/>
			</xsl:attribute>
			<xsl:attribute name="SequenceNmbr">
				<xsl:value-of select="1"/>
			</xsl:attribute>
			<xsl:if test="ns2:Envelope/@timestamp">
				<xsl:attribute name="TimeStamp">
					<xsl:value-of select="ns2:Envelope/@timestamp"/>
				</xsl:attribute>
			</xsl:if>
			<ns:Originator>
				<xsl:attribute name="CompanyShortName">
					<xsl:value-of select="&quot;FCS2&quot;"/>
				</xsl:attribute>
			</ns:Originator>
			<ns:FlightLeg>
				<ns:LegIdentifier>
					<ns:Airline>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;3&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirlineDesignator[@codeContext=&quot;IATA&quot;]"/>
					</ns:Airline>
					<ns:FlightNumber>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:FlightNumber"/>
					</ns:FlightNumber>
					<ns:OperationalSuffix>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='suffix']"/>
					</ns:OperationalSuffix>
					<xsl:choose>
                        <xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight) and count(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Route/ns1:ViaPoints/ns1:RouteViaPoint)>=1">
                            <ns:DepartureAirport>
                                <xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;3&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="if(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight/ns1:FlightId/ns1:FlightKind=&quot;Departure&quot;) then ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Route/ns1:ViaPoints/ns1:RouteViaPoint[position()=last()]/ns1:AirportCode[@codeContext='IATA'] else &quot;ZZZ&quot;"/>
                            </ns:DepartureAirport>
                        </xsl:when>
                        <xsl:otherwise>
                            <ns:DepartureAirport>
                                <xsl:attribute name="CodeContext">
                                    <xsl:value-of select="&quot;3&quot;"/>
                                </xsl:attribute>
                                <xsl:value-of select="'ZZZ'"/>
                            </ns:DepartureAirport>
                        </xsl:otherwise>
                    </xsl:choose>
					<ns:ArrivalAirport>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;3&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="if(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:FlightKind=&quot;Arrival&quot;) then ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirportCode[@codeContext='IATA'] else &quot;ZZZ&quot;"/>
					</ns:ArrivalAirport>
					<ns:OriginDate>
						<xsl:value-of select="xsd:date('2000-01-01')"/>
					</ns:OriginDate>
				</ns:LegIdentifier>
				<ns:LegData>
					<ns:OperationalStatus>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="&quot;LAN&quot;"/>
					</ns:OperationalStatus>
					<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;serviceType&quot;]">
						<ns:ServiceType>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;serviceType&quot;]"/>
						</ns:ServiceType>
					</xsl:if>
					<ns:SpecialEmphasis>
						<xsl:value-of select="if(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='vip']='true') then 'VIP' else 'ZZZ' "/>
					</ns:SpecialEmphasis>
					<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value/@propertyName=&quot;seatsFirst&quot;">
						<ns:CabinClass>
							<xsl:attribute name="Class">
								<xsl:value-of select="&quot;1&quot;"/>
							</xsl:attribute>
							<ns:SeatCapacity>
								<xsl:value-of select="xsd:integer(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;seatsFirst&quot;])"/>
							</ns:SeatCapacity>
						</ns:CabinClass>
					</xsl:if>
					<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value/@propertyName=&quot;seatsBusiness&quot;">
						<ns:CabinClass>
							<xsl:attribute name="Class">
								<xsl:value-of select="&quot;2&quot;"/>
							</xsl:attribute>
							<ns:SeatCapacity>
								<xsl:value-of select="xsd:integer(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;seatsBusiness&quot;])"/>
							</ns:SeatCapacity>
						</ns:CabinClass>
					</xsl:if>
					<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value/@propertyName=&quot;seatsEcon&quot;">
						<ns:CabinClass>
							<xsl:attribute name="Class">
								<xsl:value-of select="&quot;3&quot;"/>
							</xsl:attribute>
							<ns:SeatCapacity>
								<xsl:value-of select="xsd:integer(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;seatsEcon&quot;])"/>
							</ns:SeatCapacity>
						</ns:CabinClass>
					</xsl:if>
					<xsl:if test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare)">
                        <xsl:for-each select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare">
						<ns:CodeShareInfo>
							<ns:Airline>
								<xsl:attribute name="CodeContext">
									<xsl:value-of select="&quot;3&quot;"/>
								</xsl:attribute>
								<xsl:value-of select="ns1:AirlineDesignator[@codeContext=&quot;IATA&quot;]"/>
							</ns:Airline>
							<ns:FlightNumber>
								<xsl:value-of select="ns1:FlightNumber"/>
							</ns:FlightNumber>
						</ns:CodeShareInfo>
					</xsl:for-each>
                    </xsl:if>
					<ns:AssociatedFlightLegAircraft>
					<xsl:choose>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight)">
						<ns:Airline>
							<xsl:attribute name="CodeContext">
								<xsl:value-of select="&quot;3&quot;"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight/ns1:FlightId/ns1:AirlineDesignator[@codeContext='IATA']"/>
						</ns:Airline>
						</xsl:when>
						<xsl:otherwise>
						<ns:Airline>
							<xsl:attribute name="CodeContext">
								<xsl:value-of select="&quot;3&quot;"/>
							</xsl:attribute>
							<xsl:value-of select="'ZZZ'"/>
						</ns:Airline>
						</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
						<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight)">
						<ns:FlightNumber>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:LinkedFlight/ns1:FlightId/ns1:FlightNumber"/>
						</ns:FlightNumber>
						</xsl:when>
						<xsl:otherwise>
						<ns:FlightNumber>
							<xsl:value-of select="'0000'"/>
						</ns:FlightNumber>
						</xsl:otherwise> 
						</xsl:choose>
						<ns:DepartureAirport>
							<xsl:attribute name="CodeContext">
								<xsl:value-of select="&quot;3&quot;"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirportCode[@codeContext='IATA']"/>
						</ns:DepartureAirport>
						<ns:ArrivalAirport>
							<xsl:attribute name="CodeContext">
								<xsl:value-of select="&quot;3&quot;"/>
							</xsl:attribute>
							<xsl:value-of select="&quot;ZZZ&quot;"/>
						</ns:ArrivalAirport>
						<ns:OriginDate>
							<xsl:value-of select="xsd:date('2000-01-01')"/>
						</ns:OriginDate>
					</ns:AssociatedFlightLegAircraft>
                       <xsl:choose>
                        <xsl:when test="count(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Route/ns1:ViaPoints/ns1:RouteViaPoint)>1">
                            <xsl:variable name="data" select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Route/ns1:ViaPoints"/>
							<xsl:for-each select="$data/ns1:RouteViaPoint">
                                <xsl:variable name="pos" select="position()"/>
                                <xsl:choose>
                                    <xsl:when test="($pos) &lt; count($data/ns1:RouteViaPoint)"> 
                                        <ns:AssociatedFlightLegSchedule>
										<xsl:variable name="var" select="(($pos)-1)"/>
                                            <ns:DepartureAirport>
                                                <xsl:attribute name="CodeContext">
                                                    <xsl:value-of select="'3'"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="$data/ns1:RouteViaPoint[@sequenceNumber=$var]/ns1:AirportCode[@codeContext='IATA']"/>
                                            </ns:DepartureAirport>
                                            <ns:ArrivalAirport>
                                                <xsl:attribute name="CodeContext">
                                                    <xsl:value-of select="'3'"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="$data/ns1:RouteViaPoint[@sequenceNumber=$pos]/ns1:AirportCode[@codeContext='IATA']"/>
                                            </ns:ArrivalAirport>
                                        </ns:AssociatedFlightLegSchedule>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
					<ns:AirportResources>
						<xsl:attribute name="Usage">
							<xsl:value-of select="&quot;Actual&quot;"/>
						</xsl:attribute>
						<ns:Resource>
							<xsl:attribute name="DepartureOrArrival">
								<xsl:value-of select="&quot;Arrival&quot;"/>
							</xsl:attribute>
							<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='stand']">
								<ns:AircraftParkingPosition>
									<xsl:attribute name="Qualifier">
										<xsl:value-of select="&quot;Remote&quot;"/>
									</xsl:attribute>
									<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='stand']"/>
								</ns:AircraftParkingPosition>
							</xsl:if>
							<ns:PassengerGate>
								<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='gate']"/>
							</ns:PassengerGate>
							<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='runway']">
								<ns:Runway>
									<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='runway']"/>
								</ns:Runway>
							</xsl:if>
							<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aircraftTerminalCode'])">
							<ns:AircraftTerminal>
								<xsl:value-of select="xsd:token(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aircraftTerminalCode'])"/>
							</ns:AircraftTerminal>
							</xsl:when>
							<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='passengerTerminalCode'])">
							<ns:PublicTerminal>
								<xsl:value-of select="xsd:token(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='passengerTerminalCode'])"/>
							</ns:PublicTerminal>
							</xsl:when>
							<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='carousel']">
								<ns:BaggageClaimUnit>
									<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='carousel']"/>
								</ns:BaggageClaimUnit>
							</xsl:if>
						</ns:Resource>
					</ns:AirportResources>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:ScheduledTime)">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;ONB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;SCT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:ScheduledTime"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='eldt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;TDN&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;EST&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName=&quot;eldt&quot;]"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='eibt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;ONB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;EST&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='eibt']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='pibt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;PLN&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ONB&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='pibt']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aldt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;TDN&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aldt']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aibt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;ONB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aibt']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='firstBagTime'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;FBG&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='firstBagTime']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='lastBagTime'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;LBG&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='lastBagTime']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='tobt_upstation'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;OFB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;TAR&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='tobt_upstation']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aobt_upstation'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;OFB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='aobt_upstation']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='tldt'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;OFB&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;TAR&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='tldt']"/>
					</ns:OperationTime>
					</xsl:when>
					<xsl:when test="exists(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='atot_upstation'])">
					<ns:OperationTime>
						<xsl:attribute name="CodeContext">
							<xsl:value-of select="&quot;9750&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="OperationQualifier">
							<xsl:value-of select="&quot;TKO&quot;"/>
						</xsl:attribute>
						<xsl:attribute name="TimeType">
							<xsl:value-of select="&quot;ACT&quot;"/>
						</xsl:attribute>
						<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='atot_upstation']"/>
					</ns:OperationTime>
					</xsl:when>
					<ns:AircraftInfo>
						<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:AircraftType/ns1:AircraftTypeId/ns1:AircraftTypeCode[@codeContext='ICAO']">
							<ns:AircraftType>
								<xsl:attribute name="CodeContext">
									<xsl:value-of select="&quot;13&quot;"/>
								</xsl:attribute>
								<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:AircraftType/ns1:AircraftTypeId/ns1:AircraftTypeCode[@codeContext='ICAO']"/>
							</ns:AircraftType>
						</xsl:if>
						<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:AircraftType/ns1:AircraftTypeId/ns1:AircraftTypeCode[@codeContext='IATA']">
							<ns:AircraftSubType>
								<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:AircraftType/ns1:AircraftTypeId/ns1:AircraftTypeCode[@codeContext='IATA']"/>
							</ns:AircraftSubType>
						</xsl:if>
						<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Aircraft/ns1:AircraftId/ns1:Registration">
							<ns:Registration>
								<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Aircraft/ns1:AircraftId/ns1:Registration"/>
							</ns:Registration>
						</xsl:if>
						<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='callsign']">
							<ns:CallSign>
								<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='callsign']"/>
							</ns:CallSign>
						</xsl:if>
					</ns:AircraftInfo>
				</ns:LegData>
				<ns:TPA_Extension>
					<ns3:FlightExtensions>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'scheduleDate'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:ScheduledTime"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'gateScheduled'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='gateScheduled']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightNature'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='nature']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightisActive'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='isActive']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_pax'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_pax']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_ramp'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_ramp']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_tech'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_tech']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_catering'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_catering']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_fuel'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_fuel']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'handler_bag'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='handler_bag']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'TotalSeatCapacity'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='seatCapacity']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'CargoCapacity'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='cargoCapacity']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'paxCheck'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='paxCheck']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'bagsCheck'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='bagsCheck']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'AirlineTerminal'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='airlineTerminalCode']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'FlightTerminal'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='terminal']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'BusIsRequired'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='busIsRequired']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'divertedAirport'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='divertedAirport']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'isGeneralAviationFlight'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='isGeneralAviationFlight']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'sequenceStatus'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='sequenceStatus']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'star'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='star']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'nextStand'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='nextStand']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'landingCount'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='landingCount']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'prevBaggageClaimUnit'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='carouselPrevious']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'mcat'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='mcat']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'flightStatus'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='flightStatus']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'prevAircraftParkingPosition'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='standPrevious']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'standScheduled'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='standScheduled']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'prevPassengerGate'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='gatePrevious']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'remark'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='remark']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="'remarkType'"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Value[@propertyName='remarkType']"/>
						</ns3:Value>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="concat('ICAO','.','Airline','.',ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirlineDesignator[@codeContext='IATA'])"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirlineDesignator[@codeContext='ICAO']"/>
						</ns3:Value>
						<xsl:if test="count(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare)>=1">
							<xsl:if test="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare[position()=last()]/ns1:AirlineDesignator[@codeContext=&quot;ICAO&quot;]">
								<ns3:Value>
									<xsl:attribute name="propertyName">
										<xsl:value-of select="concat(&quot;ICAO.&quot;,&quot;Airline.&quot;,(ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare[last()]/ns1:AirlineDesignator[@codeContext='IATA']))"/>
									</xsl:attribute>
									<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:CodeShares/ns1:CodeShare[position()=last()]/ns1:AirlineDesignator[@codeContext=&quot;ICAO&quot;]"/>
								</ns3:Value>
							</xsl:if>
						</xsl:if>
						<xsl:for-each select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightState/ns1:Route/ns1:ViaPoints/ns1:RouteViaPoint">
							<xsl:if test="ns1:AirportCode[@codeContext='ICAO']">
								<ns3:Value>
									<xsl:attribute name="propertyName">
										<xsl:value-of select="concat('ICAO','.','Airport','.',ns1:AirportCode[@codeContext='IATA'])"/>
									</xsl:attribute>
									<xsl:value-of select="ns1:AirportCode[@codeContext='ICAO']"/>
								</ns3:Value>
							</xsl:if>
						</xsl:for-each>
						<ns3:Value>
							<xsl:attribute name="propertyName">
								<xsl:value-of select="concat('ICAO','.','Airport','.',ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirportCode[@codeContext='IATA'])"/>
							</xsl:attribute>
							<xsl:value-of select="ns2:Envelope/ns2:Content/ns2:FlightUpdatedNotification/ns2:Flight/ns1:FlightId/ns1:AirportCode[@codeContext='ICAO']"/>
						</ns3:Value>
					</ns3:FlightExtensions>
				</ns:TPA_Extension>
			</ns:FlightLeg>
		</ns:IATA_AIDX_FlightLegNotifRQ>
	</xsl:template>
</xsl:stylesheet>