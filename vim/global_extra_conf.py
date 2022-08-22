# Makes YCM work with python packages only in virtual environments
# see:
# http://valloric.github.io/YouCompleteMe/#configuring-through-vim-options


def Settings(**kwargs):
    client_data = kwargs['client_data']
    return {
      'interpreter_path': client_data['g:ycm_python_interpreter_path'],
      'sys_path': client_data['g:ycm_python_sys_path']
    }
