# codeNewbie

Teaching Platform for Strengthening Data Science Competence in Medicine

Digitalization has finally caught up with our everyday lives and most areas of medicine. Medical data is becoming increasingly complex, and the correct interpretation of this data enables the safety of our patients. We would like to build a platform for data science education and prepare colleagues in healthcare for the challenges that the digitalization of medicine brings. <br><br>
The focus of this teaching platform will be to introduce digital tools from the field of Data Science and explain their use through clinical examples. Through interviews and coding sessions with experts in medical data science, concrete data science problems will be solved using statistical or analytical methods and these methods will be explained in an understandable way. Our learning platform is designed to create an environment where, with the help of video tutorials and interviews, participants* get the opportunity to learn how to analyze and interpret medical data. In order to provide high-quality teaching content, our development team is supported and advised by trained medical didacticians.<br><br>
Our project is designed to help participants learn the necessary tools of medical data analysis and use them effectively in a healthcare system where medical data is becoming more complex and analytical thinking is becoming more critical.


<details><summary>JANUARY</summary>
<p>

#### We can hide anything, even code!

```ruby
   puts "Hello World"
```

</p>
</details>


<details><summary>FEBRUARY</summary>
<p>

# 16.02.2023
   
#### Showing PATH like a pro

```
Hey, what's up fellas. I'm trying to install Jekyll for running my own technical blog for doctors, but unfortunately 
I'm not able to update Ruby ... somehow I am stuck on an older version and don't know why I get a bunch of errors ... 
So while I'm trying to stay calm instead of throwing my Mac out of the OR, I found this little snippet that shows my PATH 
in a nice, concise way. Check it out ... and  yes, my PATH <br> is messed up ... the next ToDo is already planned ... 
see you later ... and as always ... sorry for my gebrochen english
```

[Link to a similar but more sophisticated tutorial](https://chriswarrick.com/blog/2018/09/04/python-virtual-environments/)

```console
echo $PATH | sed 's/:/\n/g' | uniq -c
```
<img width="592" alt="image" src="https://user-images.githubusercontent.com/36699154/219898860-c4a478fe-f788-4419-956c-d2b80a389d97.png">

#### Bringing virtualenv to the next level


```
I am still new to virtual environment world but I already know that you must use virtual environments for your project 
to separatte stuff ... so I was wondering where I should create all my environments ... I know I have only a few but it 
turns out you should store the env's in ~ (your homne directory) ... oh Meister I hope it is true ... 
```
```console
# step I
mkdir ~/virtualenvs
# step 2
python -m virtualenv venv_name
# step 3
source venv_name/bin/activate
```
```
But the coolest thing ever ... you can save time by adding a function to your .zshrc and just use the funciton name plus the name of the environment to activate it ... niiiice
```
```bash
# add this to your .zshrc or .bashrc

export WORKON_HOME=~/virtualenvs # this is where you will store all your environments

 function workon {
     source "$WORKON_HOME/$1/bin/activate"
 }
```
   
```console
# to activate a environment just type
workon env_name
```

 

</p>
</details>
