# frozen_string_literal: true

# DMARC report. Contains many records.
module Dmarcurator
  class Print
    class Report
      attr_reader :output

      def self.open_file(output:)
        return $stdout.dup if output.nil? || output.empty?
        File.open(output, 'w')
      end

      def self.print_parsed(output:, parsed:)
        file = open_file(output: output)
        file.puts "Report Organization: #{parsed.org_name}"
        file.puts "Report ID: #{parsed.dmarc_report_id}"
        file.puts "Date Range: #{parsed.begin_at} - #{parsed.end_at}"
        file.puts "Email: #{parsed.email}"
        file.puts "Extra contact info #{parsed.extra_contact_info}"
        file.puts "Policy Domain: #{parsed.policy_domain}"
        file.puts "Policy Adkim: #{parsed.policy_adkim}"
        file.puts "Policy ASPF: #{parsed.policy_aspf}"
        file.puts "Policy P: #{parsed.policy_p}"
        file.puts "Policy SP: #{parsed.policy_sp}"
        file.puts "Policy PCT: #{parsed.policy_pct}"
        file.puts "Error: #{parsed.error}"
        file.close
        parsed.records.each do |parsed_record|
          Record.print_parsed(output: output, parsed: parsed_record)
        end
      end
    end
  end
end
