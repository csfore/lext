# Source file

Right now just to list known issues

- Running max with the common flag fails to append # at the end and removes the entry completely
   - This is due to how the value of the key is mutated. Workaround will be approached later