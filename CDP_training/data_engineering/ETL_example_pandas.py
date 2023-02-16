import argparse
import os
import pandas as pd

parser = argparse.ArgumentParser(prog="CSV operations")

parser.add_argument("--source_path", help="Source of CSV to be loaded in")
parser.add_argument(
    "--output_file_name", help="Filename of output file, will be saved to ./landing"
)


def mkdir_if_not_exists(path: str) -> int:
    """Will make a directory if it does not already exist in that filepath

    Parameters
    ----------
    path : str
        path to directory

    Returns
    -------
    int
        response code:
            - 200 : successful
            - 1 : unsuccessful
    """
    if not os.path.exists(path):
        os.mkdir(path)
        return 200
    return 1


def drop_duplicates(dataframe: pd.DataFrame) -> pd.DataFrame:
    """Drops duplicates from a dataframe

    Parameters
    ----------
    dataframe : pd.DataFrame
    Returns
    -------
    pd.DataFrame
        dataframe with no duplicates
    """
    return dataframe.drop_duplicates()


def save_data(
    dataframe: pd.DataFrame,
    loading_file_path: str,
) -> int:
    """Saves data to the loading path specifed

    Parameters
    ----------
    dataframe : pd.DataFrame
    loading_file_path : str
        path to have data be saved to

    Returns
    -------
    int
        response code:
            - 200 : successful
            - 1 : unsuccessful
    """
    try:
        dataframe.to_csv(loading_file_path)
        return 200
    except FileNotFoundError:
        print("File not found.")
        return 1
    except pd.errors.EmptyDataError:
        print("No data")
        return 1
    except pd.errors.ParserError:
        print("Parse error")
        return 1
    except Exception:
        print("Some other exception")
        return 1


if __name__ == "__main__":
    """
    To use on cmd line:
    python <path_to_python_file> --source_path <insert_source_path> --output_file_name <insert_desired_file_name>

    This wills save the deduplicated file to the path ./landing/<file_name>, relative to whatever directory this is run from.
    """
    args = parser.parse_args()

    SOURCE_FILE_PATH = args.source_path

    mkdir_if_not_exists("./landing")
    LANDING_FILE_PATH = os.path.join("./landing", args.output_file_name)

    source_df = pd.read_csv(SOURCE_FILE_PATH)
    source_df_duplicated_dropped = drop_duplicates(source_df)

    save_data(source_df_duplicated_dropped, LANDING_FILE_PATH)
