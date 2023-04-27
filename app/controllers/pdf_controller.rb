class PdfController < ApplicationController
  begin
    # renderiza a página de pesquisa de PDF
    def search
    end

    def replace
      # Cria um novo objeto PDF::Reader a partir do caminho do arquivo PDF
      pdf = PDF::Reader.new(params(:pdf_path))
      # Lê o texto de cada página do PDF
      contents = pdf.pages.map { |page| page.text }.join
      #  Substitui do termo de busca
      replaced_contents = contents.gsub(params(:search_term), params(:replacement_term))
      # Define o caminho para o novo arquivo PDF que será gerado
      new_pdf_path = "#{Rails.root}/tmp/#{SecureRandom.uuid}.pdf"
      # Cria um novo objeto que representa o novo arquivo PDF
      Prawn::Document.generate(new_pdf_path) do
        text replaced_contents
      end
      # Aqui o novo arquivo PDF é enviado como resposta para o navegador do usuário
      send_file new_pdf_path, filename: 'resultado.pdf', type: 'application/pdf', disposition: 'attachment'
      flash[:notice] = 'Arquivo gerado com sucesso!'
    rescue => e
      flash[:alert] = "Houve um erro ao gerar o arquivo: #{e.message}"
      redirect_to root_path
    end
  end

  private

  def pdf_params
    params.require(:pdf).permit(:pdf_path, :search_term, :replacement_term)
  end
end
