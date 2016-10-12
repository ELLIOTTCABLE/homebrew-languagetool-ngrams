class LanguagetoolNgramsEn < Formula
  desc "LanguageTool - n-gram data (en)"
  homepage "http://wiki.languagetool.org/finding-errors-using-n-gram-data"
  url "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip"
  sha256 "2ab45d63cb11db42d4a7016ce6a86b886274f64ee88d2f1cc67b136bf11dec14"

  depends_on "languagetool" => :recommended

  def install
    # ngrams
    mkdir_p "ngrams/en"
    mv Dir["[0-9]*grams"], "ngrams/en/"
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
      * Server mode: start with the "--config #{HOMEBREW_PREFIX}/opt/languagetool-ngrams-en/server.properties" option. This properties file needs to have a "languageModel=#{HOMEBREW_PREFIX}/share/ngrams" entry.
    EOS
  end
end
