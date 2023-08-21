{pkgs, ...}:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  withPython3 = true;
  extraPython3Packages = ps: with ps; [
    (
      buildPythonPackage rec {
        pname = "asyncmake";
        version = "0.1.4";
        format = "pyproject";
        src = fetchPypi {
          inherit pname version;
          sha256 = "Gkow3fLGSElbipvbNZIJQKDAy4vcf8SL1zv41Pm8b/Y=";
        };
        doCheck = false;
        propagatedBuildInputs = with pkgs.python3Packages; [
          setuptools
          wheel
          pynvim
          pydantic
        ];
      }
    )


    (
      buildPythonPackage rec {
        pname = "textbook_nvim";
        version = "0.5.0";
        format = "pyproject";
        src = fetchPypi {
          inherit pname version;
          sha256 = "u2S8wJyEMjZh0quRpdZKhs5t+z5rNIW8mgrd6Hw+UeM=";
        };
        doCheck = false;
        propagatedBuildInputs = with pkgs.python3Packages; [
          setuptools
          wheel
          pynvim
          pydantic
          click
          rich
          jupytext
          (
            buildPythonPackage rec {
              pname = "flatlatex";
              version = "0.15";
              src = fetchPypi {
                inherit pname version;
                  sha256 = "UXDhvNT8y1K9vf8wCxS2hzBIO8RvaiqJ964rsCTk0Tk=";
                };
                doCheck = false;
                propagatedBuildInputs = with pkgs.python3Packages; [
                  regex
                ];
            }
          )
        ];
      }
    )
  ];
  defaultEditor = true;
}
