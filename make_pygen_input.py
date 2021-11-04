import jinja2
import os
import glob


def load_template(input_path, input_fname):
    """
    Returns a jinja2 template from file.
    Parameters
    ---------
    input_path : string
        Path to input template
    input_fname: str
        name of jinja2 template
    Returns
    -------
    output_template: jinja template object
    """
    input = input_path + input_fname
    with open(input, 'r') as default:
        output_template = jinja2.Template(default.read())
    return output_template


def render_input(input_path, input_fname, variable_dict,
                 output_path, output_fname):
    """
    Writes a config file to specified path. Returns nothing.
    Parameters:
    -----------
    input_path : string
        Path to input template
    input_fname : string
        name of jinja2 template
    output_path : string
        path to output files
    output_fname : string
        name of output file
    variable_dict : dictionary
        contains values for fields in jinja template.
    """
    test_template = load_template(input_path, input_fname)
    config = test_template.render(variable_dict)
    output = output_path + output_fname
    with open(output, 'wb') as outfile:
        outfile.write(config.encode())
    return


if __name__ == '__main__':

    # path = "./simulations/illinois/zero_nuclear_RE_sensitivity/"
    # path = "./simulations/illinois/zero_adv_nuclear_RE_sensitivity/"
    # path = "./simulations/illinois/expensive_nuclear_RE_sensitivity/"
    path = "./simulations/illinois/least_cost_RE_sensitivity/"

    # infile = "zero_nuclear_template.txt"
    # infile = "zero_adv_nuclear_template.txt"
    infile = "least_cost_template.txt"
    for i in range(10):
        for j in range(10):
            # outfile = f"IL_ZN_S{i}_W{j}_52.py"
            # outfile = f"IL_ZAN_S{i}_W{j}_52.py"
            # outfile = f"IL_XN_S{i}_W{j}_52.py"
            outfile = f"IL_LC_S{i}_W{j}_52.py"
            vars = {'wind_it': i, 'solar_it': j}

            rendered = render_input(input_path=path,
                                    input_fname=infile,
                                    variable_dict=vars,
                                    output_path=path,
                                    output_fname=outfile)
