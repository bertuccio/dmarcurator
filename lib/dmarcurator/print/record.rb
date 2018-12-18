# frozen_string_literal: true

module Dmarcurator
  class Print
    # DMARC report. Contains many records.
    class Record
      attr_reader :output

      def self.open_file(output:)
        return $stdout.dup if output.nil? || output.empty?
        File.open(output, 'a')
      end

      def self.print_parsed(output:, parsed:)
        file = open_file(output: output)
        file.puts "Source IP: #{parsed.source_ip}"
        file.puts "Count: #{parsed.count}"
        file.puts "Disposition: #{parsed.disposition}"
        file.puts "Policy result DKIM #{parsed.policy_result_dkim}"
        file.puts "Policy result SPF: #{parsed.policy_result_spf}"
        file.puts "Envelope TO: #{parsed.envelope_to}"
        file.puts "Header FROM: #{parsed.header_from}"
        file.puts "Auth Failed DKIM domain: #{parsed.auth_dkim_domain}"
        file.puts "Auth Failed DKIM rsult #{parsed.auth_dkim_result}"
        file.puts "Auth Failed DKIM selector: #{parsed.auth_dkim_selector}"
        file.puts "Auth Failed SPF domain: #{parsed.auth_spf_domain}"
        file.puts "Auth Failed SPF result: #{parsed.auth_spf_result}"
        file.close()
      end

    end
  end
end