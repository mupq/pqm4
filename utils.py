import os


def m4ignore(primitive, scheme, implementation):
    ignores = [os.path.join(primitive, scheme, implementation, '.m4ignore'),
               os.path.join(primitive, scheme, '.m4ignore'),
               os.path.join(primitive, '.m4ignore')]
    return any(os.path.exists(path) for path in ignores)
