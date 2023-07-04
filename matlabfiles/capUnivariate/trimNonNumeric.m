miofile="quarterlyFinances1999To2019.csv";
opts = detectImportOptions(miofile);
preview(miofile,opts)


opts = detectImportOptions(miofile,'TrimNonNumeric',true);
preview(miofile,opts)