#!/usr/bin/env python3
# Update NikajOS package database

import os
import sys

os.chdir('/mnt/h/pliki inne/visual studio/nikajos-packages/x86_64')

packages = []
for f in sorted(os.listdir('.')):
    if f.endswith('.nikaj'):
        size = os.path.getsize(f)
        # Parse package name: package-version-release-arch.nikaj
        fname = f.replace('-x86_64.nikaj', '')
        parts = fname.rsplit('-', 2)
        
        if len(parts) >= 2:
            # Handle packages like "ca-certificates-20240203-1"
            name = '-'.join(parts[:-2]) if len(parts) > 2 else parts[0]
            version = '-'.join(parts[-2:])
        else:
            name = parts[0]
            version = '1.0-1'
        
        packages.append(f'{name}|{version}|{size}|x86_64')

# Write database
db_path = '../NikajOS Official Package Repository.db'
with open(db_path, 'w') as db:
    db.write('# NikajOS Official Package Repository\n')
    db.write('# Format: pkgname|version|size|arch\n')
    for pkg in packages:
        db.write(pkg + '\n')

print(f'✅ Updated database with {len(packages)} packages')
print(f'Database: {db_path}')
