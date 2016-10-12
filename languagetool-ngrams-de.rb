class LanguagetoolNgramsDe < Formula
  desc "LanguageTool - n-gram data (de)"
  homepage "http://wiki.languagetool.org/finding-errors-using-n-gram-data"
  url "https://languagetool.org/download/ngram-data/ngrams-de-20150819.zip"
  sha256 "b338ded55f16a00a36cdf41db9234b03000fb750517e5380cfd4d10cb14f72b0"

  depends_on "languagetool" => :recommended

  def install
    # ngrams
    mkdir_p "ngrams/de"
    mv Dir["[0-9]*grams"], "ngrams/de/"
    mkdir_p HOMEBREW_PREFIX/"share/ngrams"
    share.install "ngrams"

    # server config file
    (prefix/"server.properties").write <<-EOF.undent
      languageModel=#{HOMEBREW_PREFIX}/share/ngrams
    EOF
  end

  def caveats; <<-EOS.undent
    ngrams dir:
      #{HOMEBREW_PREFIX}/share/ngrams

    usage:
      * Stand-alone user interface and LibreOffice/OpenOffice add-on: open the Options dialog and set the n-gram directory. For the stand-alone version you now need to restart LanguageTool.
      * Command line: start with the "--languagemodel #{HOMEBREW_PREFIX}/share/ngrams" option pointing to the ngram-index directory.
      * Server mode: start with the "--config #{HOMEBREW_PREFIX}/opt/languagetool-ngrams-de/server.properties" option. This properties file needs to have a "languageModel=#{HOMEBREW_PREFIX}/share/ngrams" entry.
    EOS
  end
end
