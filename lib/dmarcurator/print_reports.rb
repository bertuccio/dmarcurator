# frozen_string_literal: true

module Dmarcurator
  # Print DMARC XML reports
  class PrintReports
    attr_reader :output, :reports_path

    def initialize(output:, reports_path:)
      @output = output
      @reports_path = reports_path
    end

    def run
      puts "Printing #{reports_path}"
      Dir.foreach(reports_path) do |path|
        next if path == '.' || path == '..' || File.extname(path) != '.xml'
        puts "  #{path}"
        parsed_report = ::Dmarcurator::Parser::Report.new(xml: "#{reports_path}/#{path}")
        ::Dmarcurator::Print::Report.print_parsed(output: output, parsed: parsed_report)
      end
      puts 'Done printing :)'
    end
  end
end
