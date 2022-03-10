class LanguagetoolNgramsEn < Formula
  desc "LanguageTool - n-gram data (en)"
  homepage "http://wiki.languagetool.org/finding-errors-using-n-gram-data"
  url "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip"
  sha256 "10e548731d9f58189fc36a553f7f685703be30da0d9bb42d1f7b5bf5f8bb232c"

  depends_on "languagetool" => :recommended

  def install
    # ngrams
    mkdir_p "ngrams/en"
    mv Dir["[0-9]*grams"], "ngrams/en/"
    mkdir_p HOMEBREW_PREFIX/"share/ngrams"
    share.install "ngrams"

    # server config file
    (prefix/"server.properties").write <<-EOF
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
