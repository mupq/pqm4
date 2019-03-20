import os

from interface import Platform


def m4run(binpath):
    m4 = Platform(binpath)
    return m4.run()


def m4ignore(primitive, scheme, implementation):
    ignores = [os.path.join(primitive, scheme, implementation, '.m4ignore'),
               os.path.join(primitive, scheme, '.m4ignore'),
               os.path.join(primitive, '.m4ignore')]
    return any(os.path.exists(path) for path in ignores)
