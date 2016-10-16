## Copyright (C) 2016  Victor
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} AfficheChemins (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  Victor <victor@cp-vic>
## Created: 2016-10-15

function [] = AfficheChemins (g,nblignes,nbcolonnes)
    i=nblignes;
    j=nbcolonnes;
    fini=false;
    while !fini
      g{1}(i,j)=-10;
      tmpi=g{2}(i,j);
      j=g{3}(i,j);
      i=tmpi;
      if(i==1 && j==1) 
        fini=true;
        g{1}(i,j)=-10;
      endif
    endwhile
    imagesc(g{1});
endfunction
