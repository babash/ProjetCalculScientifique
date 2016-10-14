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
## @deftypefn {Function File} {@var{retval} =} distance_vect (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  Victor <victor@cp-vic>
## Created: 2016-10-06

function d=distance_vect(sequence1,sequence2,indicei,indicej)
    d = 0;
    taille = length (sequence1(:,1));
    for i=1:taille
      d = d + mpower(sequence1(i, indicei)-sequence2(i,indicej),2);
    endfor
    d=sqrt(d);
endfunction
