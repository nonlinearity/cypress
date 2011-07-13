# A module that handles the ability to export a patient record into the
# HITSP C32 XML format. It is intended to be mixed into the Record class
module C32Export
  # Builds a C32 XML document representing the patient.
  #
  # @return [Builder::XmlMarkup] C32 XML representation of patient data
  def to_c32(xml = nil)
    xml ||= Builder::XmlMarkup.new(:indent => 2)
    xml.ClinicalDocument("xsi:schemaLocation" => "urn:hl7-org:v3 http://xreg2.nist.gov:8080/hitspValidation/schema/cdar2c32/infrastructure/cda/C32_CDA.xsd",
                         "xmlns" => "urn:hl7-org:v3",
                         "xmlns:sdtc" => "urn:hl7-org:sdtc",
                         "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") do
      xml.realmCode( "code" => "US" )
      xml.typeId("root" => "2.16.840.1.113883.1.3", "extension" => "POCD_HD000040")
      xml.templateId("root" => "2.16.840.1.113883.3.27.1776", "assigningAuthorityName" => "CDA/R2")
      xml.templateId("root" => "2.16.840.1.113883.10.20.1", "assigningAuthorityName" => "CCD")
      xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.1", "assigningAuthorityName" => "HITSP/C32")
      xml.templateId("root" => "2.16.840.1.113883.10.20.3", "assigningAuthorityName" => "CCD")
      xml.templateId("root" => "1.3.6.1.4.1.19376.1.5.3.1.1.1")
      xml.id("root" => "2.16.840.1.113883.3.72",
             "extension" => "Cypress C32 XML Patient Record",
             "assigningAuthorityName" => "Cypress: An Open Source EHR Quality Measure Testing Framework projectcypress.org")
      xml.code("code" => "34133-9",
               "displayName" => "Summarization of patient data",
               "codeSystem" => "2.16.840.1.113883.6.1",
               "codeSystemName" => "LOINC")
      xml.title("Cypress C32 Patient Test Record")
      xml.languageCode("code" => "en-US")
      xml.recordTarget do
        xml.patientRole do
          xml.id("root" => "Cypress", "extension" => id)
          xml.addr("use" => "HP") do
            # TODO: Need patient address
          end
          xml.patient do
            xml.name do
              xml.given(first)
              xml.family(last)
            end
            xml.administrativeGenderCode("code" => gender, "codeSystem" => "2.16.840.1.113883.5.1",  "codeSystemName" => "HL7 AdministrativeGender")
            xml.birthTime("value" => Time.at(birthdate).utc.to_formatted_s(:number))
          end
        end
      end
    end
  end
end