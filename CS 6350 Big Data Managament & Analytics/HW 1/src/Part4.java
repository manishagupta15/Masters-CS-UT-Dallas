
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

import java.util.Calendar;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;

import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.util.GenericOptionsParser;



import java.util.HashMap;

public class Part4 {
	
	public static class Map1 extends Mapper<LongWritable,Text,LongWritable,Text>
	{
	
		private LongWritable user = new LongWritable();
	
	public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException
	{
		String[] line = value.toString().split("\t");
		if(line.length==2)
		{
			user.set(Long.parseLong(line[0]));
			String temp="U:"+line[1];
			context.write(user, new Text(temp));
			
			}
		}
	}
	

	public static class Map2 extends Mapper<LongWritable,Text,LongWritable,Text>
	{
	
		private LongWritable person = new LongWritable();
		
	public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException
	{
		String[] line = value.toString().split(",");
		if(line.length==10)
		{
			person.set(Long.parseLong(line[0]));
			String friendAddress="D:"+line[1]+","+line[3]+","+line[4]+","+line[5];
			context.write(person, new Text(friendAddress));
			
			}
		}
	}

	

	
	public static class Reduce1 extends Reducer<LongWritable,Text,LongWritable,Text>
	{
		
		public HashMap<String,String> map = new HashMap<String, String>();
		
		int month=0;
		int day=0;
		int year=0;
		ArrayList<String> listA=new ArrayList<String> ();
		ArrayList<String> listB=new ArrayList<String>();
		
	
		
		public void setup(Context context) throws IOException
		{
			Configuration conf=context.getConfiguration();
			map = new HashMap<String, String>();
			String userPath=conf.get("userPath");
			Path path = new Path("hdfs://localhost:9000"+userPath);
			FileSystem fs=FileSystem.get(conf);
			BufferedReader buff=new BufferedReader(new InputStreamReader(fs.open(path)));
		
			String input=buff.readLine();
			while(input!=null)
			{
				String[] temp=input.split(",");
				if(temp.length==10)
				{
					
					map.put(temp[0].trim(),temp[9].trim());
				}
			
				input=buff.readLine();
			}
			
			Calendar cal = Calendar.getInstance();
			month = cal.get(Calendar.MONTH);
			day=cal.get(Calendar.DAY_OF_MONTH);
			year=cal.get(Calendar.YEAR);
		}
		
		
		public void reduce(LongWritable key, Iterable<Text> values, Context context) throws IOException, InterruptedException
		{
			String user="",data="";
			for(Text value:values)
			{
				if(value.toString().charAt(0)=='U')
				{
					user=value.toString().substring(2);
				}
				if(value.toString().charAt(0)=='D')
				{
					data=value.toString().substring(2);
				}
			}
			
			int sum=0,count=0,avg,result;
			if(!user.isEmpty() && user!=null && data!=null && !data.isEmpty())
			{
				String[] friends=user.toString().split(",");
				for(String friend:friends)
				{
					if(map.containsKey(friend))
					{
						String dob=map.get(friend);
						String[] y=dob.split("/");
						if(y.length==3)
						{
							result=year-Integer.parseInt(y[2]);
							if(Integer.parseInt(y[0])>month)
							{
								result--;
							}
							else if(Integer.parseInt(y[0])==month)
							{	
								if(Integer.parseInt(y[1])>day)
								{
									result--;
								}
							}
							sum+=result;
							count++;
						}
						
					}
				}

					if(count!=0) 
					{
						avg=sum/count;
						String dataExt=data+","+Integer.toString(avg);
						context.write(key, new Text(dataExt));
					}	
					else
					{
						String dataExt=data+","+Integer.toString(0);
						context.write(key, new Text(dataExt));
					}	
				
			}
			
		}
		
			
	}
	
	public static class Map3 extends Mapper<LongWritable,Text,IntWritable,Text>
	{
		public void map(LongWritable key,Text value,Context context) throws IOException,InterruptedException
		{
			String line[]=value.toString().split("\t");
			if(line.length==2)
			{
				String[] data=line[1].split(",");
				if(data.length==5)
				{
					context.write(new IntWritable(Integer.parseInt(data[4])), new Text(line[0]+"\t"+line[1]));
				}
			}
		}
	}
	
	public static class Reduce2 extends Reducer<IntWritable,Text,Text,Text>
	{
		private static ArrayList<String> temp=new ArrayList<String>();
		public void reduce(IntWritable key,Iterable<Text> values,Context context) throws IOException,InterruptedException
		{
			for (Text value:values)
			{
				if(temp.size()<15)
				{
					temp.add(value.toString());
				}
			}
		}
		
		public void cleanup(Context context) throws IOException,InterruptedException
		{
			for(String l:temp) {
			context.write(new Text(""),new Text(l));
			
			}
			temp.clear();
		
		}
	}
	
	public static void main(String args[]) throws Exception
	{
		Configuration conf=new Configuration();
		String[] otherargs=new GenericOptionsParser(conf,args).getRemainingArgs();

		conf.set("userPath", otherargs[0]);
		Job jobA = Job.getInstance(conf,"Getting average age of friends");
		jobA.setJarByClass(Part4.class);
		
		MultipleInputs.addInputPath(jobA, new Path(otherargs[1]), TextInputFormat.class,Map1.class);
		MultipleInputs.addInputPath(jobA, new Path(otherargs[0]), TextInputFormat.class,Map2.class);
		
		jobA.setReducerClass(Reduce1.class);
		jobA.setOutputKeyClass(LongWritable.class);
		jobA.setOutputValueClass(Text.class);
		FileOutputFormat.setOutputPath(jobA, new Path(otherargs[2]));
		boolean mapreduce=jobA.waitForCompletion(true) ;
		
		if(mapreduce)
		{
			Configuration confB=new Configuration();

			Job jobB = Job.getInstance(confB,"Stage 2: Printing user with highest average age of friends");
			jobB.setJarByClass(Part4.class);

			jobB.setMapperClass(Map3.class);			
			jobB.setReducerClass(Reduce2.class);
			
			jobB.setMapOutputKeyClass(IntWritable.class);
			jobB.setMapOutputValueClass(Text.class);
			jobB.setOutputKeyClass(Text.class);
			jobB.setOutputValueClass(Text.class);
			
			FileInputFormat.addInputPath(jobB,new Path(otherargs[2]));
			FileOutputFormat.setOutputPath(jobB, new Path(otherargs[3]));
			System.exit(jobB.waitForCompletion(true)?0:1);
		}
	}
}


