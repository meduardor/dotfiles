import os

DIR_OF_THIS_SCRIPT = os.path.abspath( os.path.dirname( __file__ ) )
DIR_OF_THIRD_PARTY = os.path.join( DIR_OF_THIS_SCRIPT, 'third_party' )
DIR_OF_YCMD_THIRD_PARTY = os.path.join( DIR_OF_THIRD_PARTY,
                                        'ycmd', 'third_party' )


def GetStandardLibraryIndexInSysPath( sys_path ):
  for index, path in enumerate( sys_path ):
    if os.path.isfile( os.path.join( path, 'os.py' ) ):
      return index
  raise RuntimeError( 'Could not find standard library path in Python path.' )


def PythonSysPath( **kwargs ):
  sys_path = kwargs[ 'sys_path' ]

  for folder in os.listdir( DIR_OF_THIRD_PARTY ):
    sys_path.insert( 0, os.path.realpath( os.path.join( DIR_OF_THIRD_PARTY,
                                                        folder ) ) )

  for folder in os.listdir( DIR_OF_YCMD_THIRD_PARTY ):
    if folder == 'python-future':
      folder = os.path.join( folder, 'src' )
      sys_path.insert( GetStandardLibraryIndexInSysPath( sys_path ) + 1,
                       os.path.realpath( os.path.join( DIR_OF_YCMD_THIRD_PARTY,
                                                       folder ) ) )
      continue

    sys_path.insert( 0, os.path.realpath( os.path.join( DIR_OF_YCMD_THIRD_PARTY,
                                                        folder ) ) )

  return sys_path

