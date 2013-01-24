# some additional functionality to wiki-pdf export if needed
require 'iconv' unless Rails::VERSION::MAJOR >= 3
require 'fpdf/chinese'
require 'fpdf/japanese'
require 'fpdf/korean'
require 'core/rmagick'

module RedmineWikiHierarchicalExport
  module Export
    module PDF
      include Redmine::Export::PDF
      # not needed right now
      def wiki_to_pdf_with_children(title, content, attachments)
        pdf = ITCPDF.new(current_language)
        pdf.SetTitle("#{title}")
        pdf.alias_nb_pages
        pdf.footer_date = format_date(Date.today)
        pdf.AddPage
        pdf.SetFontStyle('B',11)
        pdf.Ln
        # Set resize image scale
        pdf.SetImageScale(1.6)
        pdf.SetFontStyle('',9)
        pdf.RDMwriteHTMLCell(190,5,0,0, content.to_s, attachments)
        if attachments.any?
          pdf.Ln
          pdf.SetFontStyle('B',9)
          pdf.RDMCell(190,5, l(:label_attachment_plural), "B")
          pdf.Ln
          for attachment in attachments
            pdf.SetFontStyle('',8)
            pdf.RDMCell(80,5, attachment.filename)
            pdf.RDMCell(20,5, number_to_human_size(attachment.filesize),0,0,"R")
            pdf.RDMCell(25,5, format_date(attachment.created_on),0,0,"R")
            pdf.RDMCell(65,5, attachment.author.name,0,0,"R")
            pdf.Ln
          end
        end
        pdf.Output
      end

    end
  end
end